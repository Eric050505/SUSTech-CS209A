package Lab.Lab8;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class Practice8_1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter keyword (e.g. volatile): ");
        Path path = Paths.get("E:\\Users\\Eric\\IdeaProjects\\CS209A\\src\\main\\java\\Lab\\Lab8\\src");

        try (sc) {
            String word = sc.nextLine();
            Instant startTime = Instant.now();
            int occurrences = countInDir(path, word);
            Instant endTime = Instant.now();

            System.out.println("Occurrences of " + word + ": " + occurrences);
            System.out.println("Time elapsed: " + Duration.between(startTime, endTime).toMillis() + " ms");
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    private static int countInDir(Path path, String word) throws IOException {
        ExecutorService executor = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());
        List<Callable<Integer>> tasks = new ArrayList<>();
        Pattern pattern = Pattern.compile("\\b" + Pattern.quote(word) + "\\b");

        try (Stream<Path> pathStream = Files.walk(path)) {
            List<Path> files = pathStream.filter(Files::isRegularFile).toList();
            for (Path file : files)
                tasks.add(() -> countInFile(file, pattern));
        }

        List<Future<Integer>> results = null;
        try {
            results = executor.invokeAll(tasks);
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
        }

        executor.shutdown();
        int occurrences = 0;
        try {
            assert results != null;
            for (Future<Integer> future : results)
                occurrences += future.get();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }


        return occurrences;
    }

    private static int countInFile(Path file, Pattern pattern) {
        int count = 0;
        try (BufferedReader reader = Files.newBufferedReader(file)) {
            String line;
            while ((line = reader.readLine()) != null) {
                count += (int) pattern.matcher(line).results().count();
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return count;
    }
}
