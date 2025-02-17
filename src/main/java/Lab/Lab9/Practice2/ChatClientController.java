package Lab.Lab9.Practice2;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

public class ChatClientController {
    @FXML
    private TextField inputField;

    @FXML
    private TextArea displayArea;

    private String userName;
    private ChatClient chatClient;

    public void setStage(Stage stage) {
        stage.setOnCloseRequest(e -> {
            System.out.println(userName + " is leaving");
            System.exit(0);
        });
    }

    public void setUserName(String userName, ChatClient chatClient) {
        this.userName = userName;
        displayArea.appendText("Welcome, " + userName + "!\n");
        this.chatClient = chatClient;
    }

    @FXML
    public void initialize() {
        inputField.setOnAction(e -> {
            String userInput = inputField.getText();
            if (!userInput.isEmpty()) {
                Platform.runLater(() -> {
                    displayArea.appendText(userName + ": " + userInput + "\n");
                    sendMessageToSever(userInput);
                });
                inputField.clear();
            }
        });
    }

    public String getMessage() {
        return inputField.getText();
    }

    public void displayMessage(String message) {
        displayArea.appendText(message + "\n");
    }

    private void sendMessageToSever(String message) {
        chatClient.sendMessage(message);
    }

}