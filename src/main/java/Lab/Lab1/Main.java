package Lab.Lab1;


public class Main {
    public static void main(String[] args) {
        EmployeeManage employeeManage = new EmployeeManage();
        Employee A = new Employee("A", 20);
        Employee B = new Employee("B", 30);
        Employee C = new Employee("C", 40);
        Employee D = new Employee("D", 50);

        employeeManage.addEmployees(A);
        employeeManage.addEmployees(B);
        employeeManage.addEmployees(C);
        System.out.println("---Add A B C---");
        employeeManage.displayEmployees();

        employeeManage.removeEmployees(B);
        System.out.println("---Remove B---");
        employeeManage.displayEmployees();

        employeeManage.addEmployees(new Employee("A", 20));
        employeeManage.addEmployees(D);
        System.out.println("---Add A D---");
        employeeManage.displayEmployees();
    }
}