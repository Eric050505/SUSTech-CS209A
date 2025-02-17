package Assignment.Assignment1;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.Path;
import java.util.*;
import java.util.stream.Collectors;


public class OlympicsAnalyzer implements OlympicsAnalyzerInterface {

    private final Map<String, List<String[]>> dataMap;

    public OlympicsAnalyzer(String datasetPath) {

        dataMap = new HashMap<>();

        try {
            List<Path> csvFiles = Files.walk(Paths.get(datasetPath)).filter(Files::isRegularFile).filter(path -> path.toString().endsWith(".csv")).toList();
            for (Path csvFile : csvFiles) {
                String fileName = csvFile.getFileName().toString().split(".csv")[0];
                dataMap.put(fileName, new ArrayList<>());
                try (BufferedReader bufferedReader = new BufferedReader(new FileReader(csvFile.toFile()))) {
                    String line;
                    char[] chars;
                    while ((line = bufferedReader.readLine()) != null) {
                        chars = line.toCharArray();
                        line = "";
                        for (int i = 0; i < chars.length; i++)
                            if (chars[i] == '"') {
                                i++;
                                while (i < chars.length && chars[i] != '"') {
                                    if (chars[i] == ',') chars[i] = '\0';
                                    i++;
                                }
                            }
                        for (char aChar : chars)
                            line = line.concat(String.valueOf(aChar));
                        String[] token = line.split(",");
                        dataMap.get(fileName).add(token);
                    }
                }
            }
            for (Map.Entry<String, List<String[]>> entry : dataMap.entrySet())
                entry.getValue().remove(0);
        } catch (IOException e) {
            System.out.println("Error occurs when read files: " + e.getMessage());
        }
    }

    public List<String[]> getDataset(String fileName) {
        return dataMap.get(fileName);
    }

    @Override
    public Map<String, Integer> topPerformantFemale() {
        Set<String> femaleData = getDataset("Olympic_Athlete_Bio_filtered").stream()
                .filter(e -> e[2].equals("Female")).map(e -> e[1]).collect(Collectors.toSet());

        Map<String, Integer> topFemale = getDataset("Olympic_Athlete_Event_Results")
                .stream()
                .filter(e -> femaleData.contains(e[6])
                        && e[9].equals("Gold")
                        && e[10].equals("False"))
                .collect(Collectors.groupingBy(e -> e[6],
                        Collectors.collectingAndThen(Collectors.counting()
                                , Long::intValue)));

        return topFemale.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue(Comparator.reverseOrder())
                        .thenComparing(Map.Entry.comparingByKey()))
                .limit(10)
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
    }

    @Override
    public Map<String, Float> bmiBySports() {
        Map<String, Double> BMIMap = getDataset("Olympic_Athlete_Bio_filtered")
                .stream()
                .filter(e -> !e[4].isEmpty())
                .collect(Collectors.groupingBy(e -> e[0],
                        Collectors.averagingDouble(this::getBMI)
                ));

        Map<String, Set<String>> sportsAthletesCode = getDataset("Olympic_Athlete_Event_Results")
                .stream()
                .collect(Collectors.groupingBy(e -> e[3], Collectors.mapping(e -> e[7], Collectors.toSet())));

        Map<String, Float> sportsAvgBMI = sportsAthletesCode.entrySet()
                .stream()
                .collect(
                        Collectors.toMap(
                                Map.Entry::getKey,
                                e -> e.getValue().stream().filter(BMIMap::containsKey).map(code -> BMIMap.get(code).floatValue()).toList()
                        )
                ).entrySet()
                .stream()

                .filter(e -> !e.getValue().isEmpty())
                .collect(
                        Collectors.toMap(
                                Map.Entry::getKey,
                                e -> {
                                    double avg = e.getValue().stream()
                                            .mapToDouble(Float::doubleValue)
                                            .average()
                                            .orElse(0.0);
                                    return (float) (Math.round(avg * 10.0) / 10.0);
                                }
                        ));

        return sportsAvgBMI.entrySet().stream()
                .sorted(Map.Entry.<String, Float>comparingByValue(Comparator.reverseOrder())
                        .thenComparing(Map.Entry.comparingByKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
    }

    @Override
    public Map<String, Set<Integer>> leastAppearedSport() {
        Map<String, Set<Integer>> leastAppearedSports = getDataset("Olympic_Athlete_Event_Results")
                .stream()
                .filter(e -> e[0].split(" ")[1].equals("Summer"))
                .collect(Collectors.groupingBy(e -> e[3],
                        Collectors.mapping(e -> Integer.parseInt(e[0].split(" ")[0]), Collectors.toSet())
                ));

        return leastAppearedSports.entrySet().stream()
                .sorted(Comparator.comparingInt(
                                (Map.Entry<String, Set<Integer>> e) -> e.getValue().size())
                        .thenComparing(Map.Entry.comparingByKey()))
                .limit(10)
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
    }

    @Override
    public Map<String, Integer> winterMedalsByCountry() {
        Map<String, Integer> winterMedals = getDataset("Olympic_Games_Medal_Tally")
                .stream()
                .filter(e -> e[0].split(" ")[1].equals("Winter") && Integer.parseInt(e[2]) >= 2000)
                .collect(Collectors.groupingBy(e -> e[4],
                        Collectors.summingInt(e -> Integer.parseInt(e[8]))
                ));

        return winterMedals.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue(Comparator.reverseOrder())
                        .thenComparing(Map.Entry.comparingByKey()))
                .limit(10)
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
    }

    @Override
    public Map<String, Integer> topCountryWithYoungAthletes() {
        Map<String, Integer> ageMap = getDataset("Olympic_Athlete_Bio_filtered")
                .stream()
                .filter(e -> !e[3].isEmpty())
                .collect(Collectors.toMap(
                                e -> e[0],
                                e -> {
                                    String[] born = e[3].split(" ");
                                    return 2020 - Integer.parseInt(born[born.length - 1]);
                                }
                        )
                );

        Map<String, String> countryCodeMap = getDataset("Olympics_Country")
                .stream()
                .collect(Collectors.toMap(e -> e[0], e -> e[1], (a, b) -> a));

        Map<String, Set<String>> countryAthletesMap = getDataset("Olympic_Athlete_Event_Results")
                .stream()
                .filter(e -> e[1].equals("61") && ageMap.containsKey(e[7]))
                .collect(Collectors.groupingBy(e -> e[2], Collectors.mapping(e -> e[7], Collectors.toSet())));

        Map<String, Integer> youngAges = countryAthletesMap.entrySet()
                .stream()
                .collect(Collectors.toMap(
                        e -> countryCodeMap.get(e.getKey()),
                        e -> Math.round(
                                (float) e.getValue()
                                        .stream()
                                        .mapToInt(ageMap::get)
                                        .sum() / e.getValue().size()
                        )
                ));

        return youngAges.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue()
                        .thenComparing(Map.Entry.comparingByKey()))
                .limit(10)
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
    }

    public double getBMI(String[] data) {
        double height = Double.parseDouble(data[4]);
        double weight = Double.parseDouble(data[5]);
        return 10000 * weight / (height * height);
    }

}
