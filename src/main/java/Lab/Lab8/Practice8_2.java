package Lab.Lab8;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.util.concurrent.*;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class Practice8_2 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter keyword (e.g. volatile): ");
        Path path = Paths.get("E:\\Users\\Eric\\IdeaProjects\\CS209A\\src\\main\\java\\Lab\\Lab8\\src");

        try (sc) {
            String word = sc.nextLine();
            Path resultFile = searchFirstOccurrence(path, word);

            if (resultFile != null) {
                System.out.println("Found the first file that contains " + word + ": " + resultFile);
            } else {
                System.out.println("No file contains the keyword: " + word);
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    private static Path searchFirstOccurrence(Path path, String word) throws IOException {
        ExecutorService executor = Executors.newCachedThreadPool();
        List<Callable<Path>> tasks = new ArrayList<>();
        Pattern pattern = Pattern.compile("\\b" + Pattern.quote(word) + "\\b");

        try (Stream<Path> pathStream = Files.walk(path)) {
            List<Path> files = pathStream.filter(Files::isRegularFile).toList();
            for (Path file : files)
                tasks.add(() -> searchInFile(file, pattern));
        }

        try {
            return executor.invokeAny(tasks);
        } catch (InterruptedException | ExecutionException e) {
            System.out.println("No file contains the keyword.");
            return null;
        } finally {
            executor.shutdown();
            if (executor instanceof ThreadPoolExecutor) {
                System.out.println("Largest pool size: " + ((ThreadPoolExecutor) executor).getLargestPoolSize());
            }
        }
    }

    private static Path searchInFile(Path file, Pattern pattern) throws IOException {
        try (BufferedReader reader = Files.newBufferedReader(file)) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (pattern.matcher(line).find()) return file;
                if (Thread.currentThread().isInterrupted()) {
                    System.out.println("Search in " + file + " canceled.");
                    return null;
                }

            }
        }
        throw new NoSuchElementException("Keyword not found in file: " + file);

    }
}
