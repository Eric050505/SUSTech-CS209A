package Lab.Lab3;

public class Task implements Comparable<Task> {
    String description;
    int priority;

    public Task(String description, int priority) {
        this.description = description;
        this.priority = priority;
    }

    public int compareTo(Task o) {
        if (this.priority != o.priority)
            return o.priority - this.priority;
        else
            return this.description.compareTo(o.description);
    }

    public String toString() {
        return "Task{" + "description=" + description + ", priority=" + priority + '}';
    }
}
