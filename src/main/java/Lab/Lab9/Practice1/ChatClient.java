package Lab.Lab9.Practice1;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;


public class ChatClient {
    public static void main(String[] args) {
        try {
            Socket socket = new Socket("localhost", 12000);
            System.out.println("Connected to server");

            System.out.print("Enter your name: ");
            Scanner scanner = new Scanner(System.in);
            String name = scanner.nextLine();

            // separate threads for read and write
            // because read doesn't need to wait for write
            new Thread(new MessageSender(socket, name)).start();
            new Thread(new MessageReceiver(socket)).start();

        } catch (IOException e) {
            System.out.println("Disconnected from server");
        }
    }
}

class MessageSender implements Runnable {
    private final PrintWriter out;
    private final BufferedReader consoleReader;

    public MessageSender(Socket socket, String name) throws IOException {
        this.out = new PrintWriter(socket.getOutputStream(), true);
        this.consoleReader = new BufferedReader(new InputStreamReader(System.in));
        // Send name immediately
        out.println(name);
    }

    @Override
    public void run() {
        try {
            String message;
            System.out.println("Enter the pokemon name: ");
            while ((message = consoleReader.readLine()) != null) {
                if (message.equals("EXIT")) {
                    out.println("EXIT");
                    System.out.println("Client is exiting...");
                    break;
                }
                out.println(message);
            }
        } catch (IOException e) {
            System.out.println("Error sending message");
        } finally {
            try {
                out.close();
                consoleReader.close();
            } catch (IOException e) {
                System.out.println("Error closing console");
            }
        }
    }
}

class MessageReceiver implements Runnable {
    private final BufferedReader in;

    public MessageReceiver(Socket socket) throws IOException {
        this.in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
    }

    @Override
    public void run() {
        try {
            String message;
            while ((message = in.readLine()) != null)
                System.out.println(message);
        } catch (IOException e) {
            System.out.println("Disconnected from server");
        }
    }
}