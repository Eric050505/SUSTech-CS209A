package Assignment.Assignment2.Controller;

import Assignment.Assignment2.GameClient;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.control.Label;
import lombok.Setter;

public class LoginRegisterController extends Controller {
    @Setter
    private GameClient gameClient;
    private boolean isRegistering = false;
    @FXML
    private TextField usernameField;
    @FXML
    private TextField passwordField;
    @FXML
    private Button actionButton1;
    @FXML
    private Button actionButton2;
    @FXML
    private Label messageLabel;
    @FXML
    public void initialize() {
        messageLabel.setText("Welcome! Please log in or register.");
    }

    @FXML
    private void handleAction() {
        String username = usernameField.getText();
        String password = passwordField.getText();

        if (isRegistering) gameClient.getDataSender().sendRegister(username, password);
        else gameClient.getDataSender().sendLogin(username, password);
    }

    @FXML
    private void toggleRegister() {
        isRegistering = !isRegistering;
        usernameField.clear();
        passwordField.clear();
        if (isRegistering) {
            actionButton1.setText("Register");
            actionButton2.setText("Click here to Login");
            messageLabel.setText("Please fill in your details to register.");
        } else {
            actionButton1.setText("Login");
            actionButton2.setText("Click here to Register");
            messageLabel.setText("Please fill in your details to login.");
        }
    }

}
