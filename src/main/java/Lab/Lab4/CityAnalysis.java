package Lab.Lab4;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;


public class CityAnalysis {
    public record City(String name, String state, int population) {
    }

    public static Stream<City> readCities(String filename) throws IOException {
        return Files.lines(Paths.get(filename)).map(l -> l.split(", ")).map(a -> new City(a[0], a[1], Integer.parseInt(a[2])));
    }

    public static void main(String[] args) throws IOException {

        Stream<City> cities = readCities("src/main/java/Lab/Lab4/cities.txt");
        // Q1: count how many cities there are for each state
        Map<String, Long> cityCountPerState = cities.collect(Collectors.groupingBy(City::state, Collectors.counting()));
        cityCountPerState.forEach((state, count) -> System.out.print(state + "=" + count + ", "));
        System.out.println();

        cities = readCities("src/main/java/Lab/Lab4/cities.txt");
        // Q2: count the total population for each state
        Map<String, Integer> statePopulation = cities.collect(Collectors.groupingBy(City::state, Collectors.summingInt(City::population)));
        statePopulation.forEach((state, count) -> System.out.print(state + "=" + count + ", "));
        System.out.println();

        cities = readCities("src/main/java/Lab/Lab4/cities.txt");
        // Q3: for each state, get the city with the longest name
        Map<String, String> longestCityNameByState = cities.collect(Collectors.
                groupingBy(City::state,
                        Collectors.collectingAndThen(
                                Collectors.maxBy(Comparator.comparingInt(c -> c.name().length())),
                                optional -> optional.map(City::name).orElse(null)
                        )
                )
        );
        longestCityNameByState.forEach((state, count) -> System.out.print(state + "=" + count + ", "));
        System.out.println();

        cities = readCities("src/main/java/Lab/Lab4/cities.txt");
        // Q4: for each state, get the set of cities with >500,000 population
        Map<String, Set<City>> largeCitiesByState = cities.collect(Collectors.
                groupingBy(City::state,
                        Collectors.filtering(c -> c.population > 500000,
                                Collectors.toSet())
                )
        );
        largeCitiesByState.entrySet().removeIf(e->e.getValue().isEmpty());
        largeCitiesByState.forEach((state, count) -> System.out.print(state + "=" + count + ", "));
        System.out.println();

    }
}
