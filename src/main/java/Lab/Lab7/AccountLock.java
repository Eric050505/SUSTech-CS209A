package Lab.Lab7;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AccountLock extends Account {
    private final Lock balanceChangeLock;

    public AccountLock() {
        super();
        this.balanceChangeLock = new ReentrantLock();
    }

    @Override
    public void deposit(double money) {
        balanceChangeLock.lock();

        try {
            double newBalance = super.getBalance() + money;
            try {
                Thread.sleep(5);   // Simulating this service takes some processing time
            } catch (InterruptedException ex) {
                System.out.println(ex.getMessage());
            }
            super.setBalance(newBalance);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        finally {
            balanceChangeLock.unlock();
        }

    }

}
