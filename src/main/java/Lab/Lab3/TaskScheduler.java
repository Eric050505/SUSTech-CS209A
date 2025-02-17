package Lab.Lab3;

import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;

public class TaskScheduler {
    PriorityQueue<Task> tasks;

    public TaskScheduler() {
        tasks = new PriorityQueue<>();
    }

    public void addTask(String description, int priority) {
        tasks.offer(new Task(description, priority));
    }

    public void finishNextTask() {
        if (!tasks.isEmpty())
            tasks.poll();
    }

    public List<Task> getTopKTasks(int k) {
        List<Task> topTasks = new ArrayList<>();
        PriorityQueue<Task> copy = new PriorityQueue<>(tasks);
        for (int i = 0; i < k; i++) {
            topTasks.add(copy.poll());
        }
        return topTasks;
    }

}