package Lab.Lab3;

import java.util.List;

public class TaskSchedulerTest {
    public static void main(String[] args) {
        TaskScheduler scheduler = new TaskScheduler();
        scheduler.addTask("Write report", 2);
        scheduler.addTask("Respond to emails", 1);
        scheduler.addTask("Prepare presentation", 3);
        scheduler.addTask("Code review", 2);
        scheduler.addTask("Team meeting", 5);
        scheduler.addTask("Project planning", 4);
        scheduler.addTask("Client follow-up", 3);
        scheduler.addTask("Bug fixing", 2);
        scheduler.addTask("Lunch break", 1);
        scheduler.addTask("Team outing", 1);

        System.out.println("Top 5 priority tasks:");
        List<Task> top5Tasks = scheduler.getTopKTasks(5);
        top5Tasks.forEach(System.out::println);
        System.out.println("\nFinishing the next 3 highest priority tasks\n");
        scheduler.finishNextTask();
        scheduler.finishNextTask();
        scheduler.finishNextTask();
        System.out.println("Top 6 priority tasks:");
        List<Task> top6Tasks = scheduler.getTopKTasks(6);
        top6Tasks.forEach(System.out::println);
    }

}
