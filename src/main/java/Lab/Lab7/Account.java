package Lab.Lab7;

public abstract class Account {
    private double balance;

    public Account() {
        balance = 0;
    }

    public abstract void deposit(double money);

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }
}