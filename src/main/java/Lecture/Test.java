/*
package Lecture;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import java.util.stream.DoubleStream;
import java.util.Collection;
import java.util.Comparator;
import static org.junit.Assert.assertEquals;

@TestInstance(TestInstance.Lifecycle.PER_METHOD)
class CalculatorTest {
    Calculator c;

    @BeforeEach
    void setUp() {
        System.out.println("Setting up calculator");
        c = new Calculator();
    }

    @Test
    void add() {
        System.out.println(Calculator.add(2, 2));
        assertEquals(4.0, Calculator.add(2, 2));
    }

    @Test
    void multiply() {
        assertEquals(4, Calculator.multiply(2, 2));
    }

    @AfterEach
    void tearDown() {
        c = null;
        System.out.println("Tearing down calculator");
    }
}

class Calculator {
    static double add(double... operands) {
        return DoubleStream.of(operands).sum();
    }

    static double multiply(double... operands) {
        return DoubleStream.of(operands).reduce(1, (a, b) -> a * b);
    }
}*/
package Lecture;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Set;
import java.util.Collections;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Test {
    public static void main(String[] args) {
        Path workingDir = Paths.get(System.getProperty("user.dir"));
        Path dir = Paths.get(workingDir.toUri());
        try(Stream<Path> entries = Files.walk(dir)){
            entries.forEach(p -> System.out.println(p.toAbsolutePath()));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        Stream<String> stream = Stream.of("1a", "1bb", "1c", "2a", "2a", "2bb");
        Map<Character, Set<String>> group =
                stream.collect(Collectors.groupingBy(s->s.charAt(0),
                        Collectors.mapping(s->s.substring(1), Collectors.toSet())));
        int a = 1;
    }
}