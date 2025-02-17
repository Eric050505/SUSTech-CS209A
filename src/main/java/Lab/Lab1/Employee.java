package Lab.Lab1;

import java.util.Objects;

public class Employee {
    private String name;
    private int age;

    public Employee(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + "\nAge: " + age);
    }

    public String getName() {
        return name;
    }

    @Override
    public boolean equals(Object object) {
        if (this == object)
            return true;
        Employee employee = (Employee) object;
        return Objects.equals(name, employee.name) && age == employee.age;
    }

}
