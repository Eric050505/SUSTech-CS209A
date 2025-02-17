package Lab.Lab13;

import java.lang.reflect.Field;
import java.util.Scanner;

public class DataValidator {
    public static boolean validate(Object obj) throws IllegalAccessException, NoSuchFieldException {
        boolean valid = true;
        for (Field field : obj.getClass().getDeclaredFields()) {
            MinLength minLength = field.getAnnotation(MinLength.class);
            if (minLength != null) {
                field.setAccessible(true);
                String value = (String) field.get(obj);
                if (value.length() < minLength.min()) {
                    System.out.println("Validation failed for field " + field.getName() + ": should have a minimum length of " + minLength.min());
                    valid = false;
                }
            }

            CustomValidations customValidations = field.getAnnotation(CustomValidations.class);
            if (customValidations != null) {
                String value = (String) field.get(obj);
                for (CustomValidation customValidation : customValidations.value())
                    switch (customValidation.rule()) {
                        case NO_USERNAME -> {
                            Field usernameFiled = obj.getClass().getDeclaredField("username");
                            usernameFiled.setAccessible(true);
                            String username = (String) usernameFiled.get(obj);
                            if (value.contains(username)) {
                                System.out.println("Validation failed for field password: should not contain username");
                                valid = false;
                            }
                        }
                        case HAS_BOTH_DIGITS_AND_LETTERS -> {
                            boolean hasDigit = false;
                            boolean hasLetter = false;
                            for (char c : value.toCharArray()) {
                                if (Character.isDigit(c)) hasDigit = true;
                                else if (Character.isLetter(c)) hasLetter = true;
                            }
                            if (!hasDigit || !hasLetter) {
                                System.out.println("Validation failed for field password: should have both letters and digits");
                                valid = false;
                            }
                        }
                    }
            }

            CustomValidation[] customValidationArray = field.getAnnotationsByType(CustomValidation.class);
            for (CustomValidation customValidation : customValidationArray) {
                String value = (String) field.get(obj);
                if (customValidation.rule().equals(Rule.ALL_LOWERCASE)) {
                    if (!value.equals(value.toLowerCase())) {
                        System.out.println("Validation failed for field username: should be all lowercase");
                        valid = false;
                    }
                }
            }

        }
        return valid;
    }

    public static void main(String[] args) throws IllegalAccessException, NoSuchFieldException {
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.print("Username: ");
            String username = sc.next();
            System.out.print("Password: ");
            String pwd = sc.next();
            User user = new User(username, pwd);
            if (validate(user)) {
                System.out.println("Success!");
                break;
            }
        }
    }
}
