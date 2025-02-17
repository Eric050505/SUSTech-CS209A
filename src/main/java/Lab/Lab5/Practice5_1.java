package Lab.Lab5;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.stream.IntStream;

public class Practice5_1 {

    public static void main(String[] args) {
        try {
            String inputFile = "src/main/java/Lab/Lab5/input.txt";
            String outputFile = "src/main/java/Lab/Lab5/output.txt";

            StringBuilder inputMapBuilder = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile), StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    inputMapBuilder.append(line).append("\n");
                }
            }

            StringBuilder outputMap = getStringBuilder(inputMapBuilder);

            try (Writer writer = new OutputStreamWriter(new FileOutputStream(outputFile), StandardCharsets.UTF_16)) {
                writer.write(outputMap.toString());
            }

        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    private static StringBuilder getStringBuilder(StringBuilder inputMapBuilder) {
        String inputMap = inputMapBuilder.toString();
        StringBuilder outputMap = new StringBuilder();

        IntStream codePoints = inputMap.codePoints();
        codePoints.forEach(e -> {
            switch (e) {
                case 0x007E:
                    outputMap.append("❄");
                    break;
                case 0x1F332:
                    outputMap.append("⬜");
                    break;
                default:
                    outputMap.append(Character.toChars(e));
                    break;
            }
        });
        return outputMap;
    }
}
