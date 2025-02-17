package Assignment.Assignment2.Controller;

import Assignment.Assignment2.GameClient;
import Assignment.Assignment2.Model.User;
import javafx.application.Platform;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListCell;
import javafx.scene.control.ListView;
import javafx.scene.layout.HBox;
import lombok.Setter;

import java.util.Arrays;
import java.util.Objects;
import java.util.stream.Collectors;

public class UserController extends Controller {

    @FXML
    private Button startGameButton;

    @FXML
    private Button logoutButton;

    @FXML
    private Label textField;

    @FXML
    private ListView<String> userDetailsList;

    @Setter
    private GameClient gameClient;

    @Setter
    private User user;

    @FXML
    private void startGame() {
        gameClient.showOptionDialog();
    }

    @FXML
    private void logout() {
        gameClient.getDataSender().sendLogout();
    }

    @FXML
    private void queryHistory() {
        gameClient.getDataSender().sendQuery(user.getUsername());
    }

    @FXML
    private void refresh() {
        gameClient.getDataSender().sendRefresh();
    }

    @FXML
    private void initialize() {
        Platform.runLater(() -> {
            textField.setText("Welcome, " + user.getUsername() + "!\nIf the online users are empty, please refresh.");
        });
    }

    public void showUser(String[] info) {
        Platform.runLater(() -> {
            userDetailsList.getItems().clear();
            ObservableList<String> userDetails = FXCollections.observableArrayList(Arrays.stream(info).filter(Objects::nonNull).collect(Collectors.toList()));

            userDetailsList.setItems(userDetails);
            userDetailsList.setCellFactory(param -> new ListCell<>() {
                @Override
                protected void updateItem(String item, boolean empty) {
                    super.updateItem(item, empty);
                    if (empty || item == null) {
                        setText(null);
                        setGraphic(null);
                    } else {
                        HBox hbox = new HBox(10);
                        Label userInfoLabel = new Label(item);
                        hbox.getChildren().add(userInfoLabel);

                        Button userButton = new Button("Game History");
                        userButton.setOnAction(event -> gameClient.getDataSender().sendQuery(getUsername(item)));
                        hbox.getChildren().add(userButton);

                        if (item.contains("Matching: true")) {
                            Button matchingButton = new Button("Join Game");
                            matchingButton.setOnAction(event -> gameClient.getDataSender().sendJoin(getUsername(item)));
                            hbox.getChildren().add(matchingButton);
                        }

                        setGraphic(hbox);
                    }
                }
            });
        });
    }

    private String getUsername(String item) {
        String prefix = "Username: ";
        int startIndex = item.indexOf(prefix) + prefix.length();
        int endIndex = item.indexOf(" |", startIndex);
        if (startIndex >= 0 && endIndex > startIndex)
            return item.substring(startIndex, endIndex).trim();
        return "";
    }

}
