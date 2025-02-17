package Lab.Lab7;

import org.openjdk.jmh.annotations.*;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class Test {
    @State(Scope.Thread)
    public static class MyState {
        AccountLock account_lock;
        AccountSync account_sync;
        ExecutorService service;

        @Setup(Level.Iteration)
        public void setUp() {
        }

    }

    @Benchmark
    @OutputTimeUnit(TimeUnit.MILLISECONDS)
    public static void testAccountLock(MyState state) {
        state.account_lock = new AccountLock();
        state.service = Executors.newFixedThreadPool(100);

        for (int i = 1; i <= 100; i++) {
            state.service.execute(new DepositThread(state.account_lock, 10));
        }

        state.service.shutdown();
        while (!state.service.isTerminated()) {
        }
        System.out.println("Balance: " + state.account_lock.getBalance());
    }

    @Benchmark
    @OutputTimeUnit(TimeUnit.MILLISECONDS)
    public static void testAccountSync(MyState state) {
        state.account_sync = new AccountSync();
        state.service = Executors.newFixedThreadPool(100);

        for (int i = 1; i <= 100; i++) {
            state.service.execute(new DepositThread(state.account_sync, 10));
        }

        state.service.shutdown();
        while (!state.service.isTerminated()) {
        }
        System.out.println("Balance: " + state.account_sync.getBalance());
    }

    public static void main(String[] args) throws RunnerException {
        Options options = new OptionsBuilder()
                .include(Test.class.getSimpleName())
                .measurementIterations(3)
                .warmupIterations(1)
                .mode(Mode.AverageTime)
                .forks(1)
                .shouldDoGC(true)
                .build();
        new Runner(options).run();
    }
}