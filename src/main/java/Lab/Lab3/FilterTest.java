package Lab.Lab3;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class FilterTest {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("Please input the function no:");
            System.out.println("1 - Get even numbers");
            System.out.println("2 - Get odd numbers");
            System.out.println("3 - Get prime numbers");
            System.out.println("0 - Quit");

            int choice = sc.nextInt();
            if (choice == 0) break;

            System.out.println("Input the integer list:");
            sc.nextLine();
            String input = sc.nextLine();
            List<Integer> list = new ArrayList<>();
            String[] numbers = input.split(" ");
            for (String number : numbers)
                list.add(Integer.parseInt(number));
            List<Integer> resultList = switch (choice) {
                case 1 -> filter(list, integer -> integer % 2 == 0);
                case 2 -> filter(list, integer -> integer % 2 == 1);
                case 3 -> filter(list, FilterTest::isPrime);
                default -> new ArrayList<>();
            };
            System.out.println("Filter results:");
            System.out.println(resultList);
        }
    }

    public static <T> List<T> filter(List<T> list, MyPredicate<T> predicate) {
        List<T> filteredList = new ArrayList<>();
        for (T item : list) {
            if (predicate.test(item)) {
                filteredList.add(item);
            }
        }
        return filteredList;
    }

    public static boolean isPrime(int number) {
        if (number <= 1) return false;
        for (int i = 2; i <= Math.sqrt(number); i++) {
            if (number % i == 0) return false;
        }
        return true;
    }
}
