package Lab.Lab1;

import java.util.ArrayList;
import java.util.Comparator;

public class EmployeeManage {
    private final ArrayList<Employee> employees;

    public EmployeeManage() {
        this.employees = new ArrayList<>();
    }

    public void addEmployees(Employee employee) {
        if (!this.employees.contains(employee))
            employees.add(employee);
        else
            System.out.printf("Employee %s already exists! \n", employee.getName());
    }

    public void removeEmployees(Employee employee) {
        employees.remove(employee);
    }

    public void displayEmployees() {
        ArrayList<Employee> temp = employees;
        temp.sort(Comparator.comparing(Employee::getName));
        for (Employee employee : temp) {
            employee.printInfo();
        }
        System.out.println();
    }

}
