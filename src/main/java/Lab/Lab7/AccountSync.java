package Lab.Lab7;

public class AccountSync extends Account {

    public AccountSync() {
        super();
    }

    @Override
    public synchronized void deposit(double money) {
        double newBalance = super.getBalance() + money;
        try {
            Thread.sleep(5);
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
        }
        super.setBalance(newBalance);
    }
}
