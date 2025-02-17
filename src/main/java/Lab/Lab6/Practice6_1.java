package Lab.Lab6;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;
import java.util.jar.JarEntry;
import java.util.jar.JarInputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class Practice6_1 {
    public static void main(String[] args) {
        String srcPath = System.getProperty("user.dir");
        String path = srcPath.concat("/src/main/java/Lab/Lab6/src.zip");
        Set<String> JavaFiles = new HashSet<>();
        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(path))) {
            ZipEntry ze = zis.getNextEntry();

            while (ze != null) {
                String fileName = ze.getName();
                if (fileName.startsWith("java/io") || fileName.startsWith("java/nio") && fileName.endsWith(".java"))
                    JavaFiles.add(fileName);
                ze = zis.getNextEntry();
            }

            System.out.println("In .zip: # of .java files in java.io/java.nio packages: " + JavaFiles.size());
            int i = 0;
            for (String fileName : JavaFiles) {
                System.out.println(fileName);
                i++;
                if (i == 3) break;
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        path = srcPath.concat("/src/main/java/Lab/Lab6/rt.jar");
        Set<String> ClassFiles = new HashSet<>();
        HashMap<String, Integer> classHasInnerClass = new HashMap<>();

        try (JarInputStream jis = new JarInputStream(new FileInputStream(path))) {
            JarEntry je = jis.getNextJarEntry();
            while (je != null) {
                String fileName = je.getName();
                String[] parts = fileName.split("\\$");
                if (fileName.startsWith("java/io") || fileName.startsWith("java/nio") && fileName.endsWith(".class")) {
                    ClassFiles.add(fileName);
                    if (parts.length > 1)
                        classHasInnerClass.compute(parts[1], (key, value) -> value == null ? 1 : value + 1);
                }
                je = jis.getNextJarEntry();
            }

            System.out.println("\nIn .zip: # of .class files in java.io/java.nio packages: " + ClassFiles.size());
            int i = 0;
            for (String fileName : ClassFiles) {
                System.out.println(fileName);
                i++;
                if (i == 3) break;
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        int total = classHasInnerClass.values()
                .stream()
                .mapToInt(Integer::intValue)
                .sum();

        System.out.println("\n# of class with inner class: " + classHasInnerClass.size());
        System.out.println("# of inner classes: " + total);

        List<String> noClassFiles = new ArrayList<>();
        for (String fileName : JavaFiles)
            if (!ClassFiles.contains(fileName.split("\\.")[0].concat(".class")))
                noClassFiles.add(fileName);

        System.out.println("\n# of .java files with corresponding .class: " + (JavaFiles.size() - noClassFiles.size()));

        System.out.println("# of .java without its .class: " + noClassFiles.size());
        for (String fileName : noClassFiles)
            System.out.println(fileName.split("\\.")[0]);


        List<String> noJavaFiles = new ArrayList<>();
        for (String fileName : ClassFiles)
            if (!JavaFiles.contains(fileName.split("\\.")[0].concat(".java")) && !fileName.contains("$"))
                noJavaFiles.add(fileName);
        System.out.println("\n# of .class without its .java files: " + noJavaFiles.size());
        for (String fileName : noJavaFiles)
            System.out.println(fileName.split("\\.")[0]);
    }

}
