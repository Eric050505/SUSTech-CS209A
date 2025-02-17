package Lab.Lab9.Practice2;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TextInputDialog;
import javafx.stage.Stage;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Optional;

public class ChatClient extends Application {
    private Socket socket;
    private BufferedReader in;
    private PrintWriter out;
    private String userName;
    private ChatClientController controller;

    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(ChatClient.class.getResource("client-view.fxml"));
        Parent root = fxmlLoader.load();

        TextInputDialog dialog = new TextInputDialog();
        dialog.setHeaderText("Enter your name:");

        Optional<String> result = dialog.showAndWait();
        userName = result.orElse("null");

        controller = fxmlLoader.getController();
        controller.setUserName(userName, this);
        controller.setStage(stage);

        Scene scene = new Scene(root, 320, 240);
        stage.setTitle(userName);
        stage.setScene(scene);
        stage.show();

        connectToServer();
        // new Thread(new MessageSender()).start();
        new Thread(new MessageReceiver()).start();
    }

    public static void main(String[] args) {
        launch();
    }

    private void connectToServer() {
        try {
            socket = new Socket("localhost", 2345);
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            out = new PrintWriter(socket.getOutputStream(), true);
            out.println(userName);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

/*    class MessageSender implements Runnable {
        @Override
        public void run() {
            try {
                while (true) {
                    String message = controller.getMessage();
                    if (message != null && !message.isEmpty())
                        out.println(message);
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }*/

    class MessageReceiver implements Runnable {
        @Override
        public void run() {
            try {
                String message;
                while ((message = in.readLine()) != null) {
                    String finalMessage = message;
                    Platform.runLater(() -> controller.displayMessage(finalMessage));
                }
            } catch (IOException e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public void sendMessage(String message) {
        out.println(message);
    }
}

