package Assignment.Assignment2;

import Assignment.Assignment2.Controller.Controller;
import Assignment.Assignment2.Controller.GameController;
import Assignment.Assignment2.Controller.UserController;
import Assignment.Assignment2.Model.GameRecord;
import Assignment.Assignment2.Model.GameSession;
import Assignment.Assignment2.Model.User;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import lombok.Getter;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class GameClient extends Application {
    private static final String SERVER_ADDRESS = "localhost";
    private static final int SERVER_PORT = 12345;

    @Getter
    private User user;
    private Socket socket;

    private Controller controller;
    private Stage primaryStage;
    private ExecutorService executorService;
    private Dialog<String> waitingDialog;
    private boolean inGame = false;

    @Getter
    private DataSender dataSender;
    private DataReceiver dataReceiver;

    public GameClient() {
        try {
            socket = new Socket(SERVER_ADDRESS, SERVER_PORT);
            executorService = Executors.newSingleThreadExecutor();
            dataSender = new DataSender(socket);
            dataReceiver = new DataReceiver(socket);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void start(Stage primaryStage) throws IOException {
        if (!isServerConnected()) {
            showDialog("Connection Failed", "Unable to connect to the server.");
            return;
        }
        this.primaryStage = primaryStage;
        switchToLRGUI();
        dataReceiver.startServerListener();
    }

    private void switchToGameGUI(GameSession gameSession) {
        Platform.runLater(() -> {
            inGame = true;
            if (waitingDialog != null) {
                waitingDialog.close();
                waitingDialog = null;
            }
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("GameGUI.fxml"));
            VBox root = null;
            try {
                root = fxmlLoader.load();
            } catch (IOException e) {
                e.printStackTrace();
            }
            controller = fxmlLoader.getController();
            controller.setGameClient(this);
            controller.setGameSession(gameSession);

            controller.setUser(user);
            User opponent = gameSession.getUser1();
            if (opponent.equals(user)) opponent = gameSession.getUser2();
            controller.setOpponent(opponent);

            controller.setCurrentMovingPlayer(gameSession.getUser1());
            controller.updateGameGUI();

            Scene scene = new Scene(root, 800, 800);
            primaryStage.setTitle("Linking Game: Current Player: " + user.getUsername());
            primaryStage.setScene(scene);
            primaryStage.show();
        });
    }

    private void switchToLRGUI() {
        Platform.runLater(() -> {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("LoginRegister.fxml"));
            VBox root;
            try {
                root = fxmlLoader.load();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            controller = fxmlLoader.getController();
            controller.setGameClient(this);
            primaryStage.setOnCloseRequest(e -> {
                if (user != null) dataSender.sendDisconnect();
                System.exit(0);
            });

            Scene scene = new Scene(root, 500, 300);
            primaryStage.setTitle("2024Fall-CS209-Assignment2: Linking Game");
            primaryStage.setScene(scene);
            primaryStage.show();
        });
    }

    private void switchSceneToUserGUI() throws RuntimeException {
        Platform.runLater(() -> {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("UserGUI.fxml"));
            VBox root;
            try {
                root = fxmlLoader.load();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            controller = fxmlLoader.getController();
            controller.setGameClient(this);
            controller.setUser(user);

            Scene scene = new Scene(root, primaryStage.getWidth(), primaryStage.getHeight());
            primaryStage.setTitle("Welcome, " + user.getUsername());
            primaryStage.setScene(scene);
            primaryStage.show();
        });
    }

    private boolean isServerConnected() {
        return socket != null && socket.isConnected() && !socket.isClosed();
    }

    public static String encryptPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes(StandardCharsets.UTF_8));
            byte[] digest = md.digest();
            StringBuilder hexString = new StringBuilder();
            for (byte b : digest) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Error encrypting password: " + e.getMessage());
            return null;
        }
    }

    private static String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        return sdf.format(date);
    }

    public void showDialog(String title, String body) {
        Platform.runLater(() -> {
            Dialog<String> dialog = new Dialog<>();
            dialog.setTitle(title.replace('_', ' '));
            dialog.setHeaderText(null);

            Label label = new Label(body);
            DialogPane dialogPane = new DialogPane();
            dialogPane.setContent(label);

            dialogPane.getButtonTypes().add(new ButtonType("OK", ButtonBar.ButtonData.OK_DONE));
            dialog.setDialogPane(dialogPane);

            Stage stage = (Stage) dialog.getDialogPane().getScene().getWindow();
            stage.setOpacity(0.9);
            stage.setWidth(400);
            stage.setHeight(200);
            dialog.showAndWait();
        });
    }

    private void showDialog(String body) {
        Platform.runLater(() -> {
            inGame = false;
            waitingDialog = new Dialog<>();
            waitingDialog.setTitle("OPPONENT DISCONNECT");
            waitingDialog.setHeaderText(null);

            Label label = new Label(body + "\nWait until reconnection or close the window so that this game can not recover!");
            DialogPane dialogPane = new DialogPane();
            dialogPane.setContent(label);

            dialogPane.getButtonTypes().add(new ButtonType("Cancel to join others", ButtonBar.ButtonData.CANCEL_CLOSE));
            waitingDialog.setOnCloseRequest(dialogEvent -> {
                if (!inGame) {
                    switchSceneToUserGUI();
                    dataSender.sendCancelWaiting();
                }
                waitingDialog.close();
                waitingDialog = null;
            });
            waitingDialog.setDialogPane(dialogPane);

            Stage stage = (Stage) waitingDialog.getDialogPane().getScene().getWindow();
            stage.setOpacity(0.9);
            stage.setWidth(600);
            stage.setHeight(200);
            waitingDialog.showAndWait();
        });
    }

    private void showDialog() {
        Platform.runLater(() -> {
            waitingDialog = new Dialog<>();
            waitingDialog.setTitle("WAIT MATCHING");
            waitingDialog.setHeaderText(null);

            String body = "Matching your opponent...";

            String preferBoardSize = String.valueOf(user.getPreferBoardSize());
            if (preferBoardSize.equals("-1")) preferBoardSize = "ANY SIZE";
            Label label = new Label(body + "\nBoard Size Selected: " + preferBoardSize);
            DialogPane dialogPane = new DialogPane();
            dialogPane.setContent(label);

            dialogPane.getButtonTypes().add(new ButtonType("Cancel", ButtonBar.ButtonData.CANCEL_CLOSE));
            waitingDialog.setOnCloseRequest(dialogEvent -> {
                if (!inGame) dataSender.sendCancelMatching();
                waitingDialog.close();
            });
            waitingDialog.setDialogPane(dialogPane);

            Stage stage = (Stage) waitingDialog.getDialogPane().getScene().getWindow();
            stage.setOpacity(0.9);
            stage.setWidth(400);
            stage.setHeight(200);
            waitingDialog.showAndWait();
        });
    }

    private void showDialog(List<GameRecord> gameRecords) {
        Platform.runLater(() -> {
            Dialog<String> dialog = new Dialog<>();
            dialog.setTitle("Game Records");
            dialog.setHeaderText(null);

            VBox vbox = new VBox(10);
            vbox.setStyle("-fx-padding: 10;");

            for (GameRecord record : gameRecords) {
                String result = record.isWin() ? "Won" : "Lost";
                String gameInfo = "Opponent: " + record.getOpponent() + " | Result: " + result + " | Date: " + formatDate(record.getDate());

                Label gameRecordLabel = new Label(gameInfo);
                vbox.getChildren().add(gameRecordLabel);
            }

            ButtonType okButton = new ButtonType("OK", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().add(okButton);
            dialog.getDialogPane().setContent(vbox);
            Stage stage = (Stage) dialog.getDialogPane().getScene().getWindow();
            stage.setOpacity(0.9);
            stage.setWidth(400);
            stage.setHeight(500);
            dialog.showAndWait();
        });
    }

    public void showOptionDialog() {
        Platform.runLater(() -> {
            Dialog<String> optionDialog = new Dialog<>();
            optionDialog.setTitle("Select Your Preferred Board Size");

            VBox optionContent = new VBox(10);
            optionContent.setAlignment(Pos.CENTER);

            Button button2 = new Button("2");
            Button button4 = new Button("4");
            Button button6 = new Button("6");
            Button button8 = new Button("8");
            Button button12 = new Button("12");
            Button buttonRandom = new Button("Random: Faster Matching!");

            button2.setOnAction(e -> {
                user.setPreferBoardSize(2);
                optionDialog.setResult("2");
            });
            button4.setOnAction(e -> {
                user.setPreferBoardSize(4);
                optionDialog.setResult("4");
            });
            button6.setOnAction(e -> {
                user.setPreferBoardSize(6);
                optionDialog.setResult("6");
            });
            button8.setOnAction(e -> {
                user.setPreferBoardSize(8);
                optionDialog.setResult("8");
            });
            button12.setOnAction(e -> {
                user.setPreferBoardSize(12);
                optionDialog.setResult("12");
            });
            buttonRandom.setOnAction(e -> {
                user.setPreferBoardSize(-1);
                optionDialog.setResult("Random");
            });

            optionContent.getChildren().addAll(button2, button4, button6, button8, button12, buttonRandom);
            optionDialog.getDialogPane().setContent(optionContent);

            Stage stage = (Stage) optionDialog.getDialogPane().getScene().getWindow();
            stage.setOpacity(0.9);
            stage.setWidth(300);
            stage.setHeight(400);

            optionDialog.showAndWait().ifPresent(selectedOption -> dataSender.sendMatch());
        });
    }

    public class DataSender {

        private final ObjectOutputStream out;

        private DataSender(Socket socket) throws IOException {
            out = new ObjectOutputStream(socket.getOutputStream());
        }

        private void sendDisconnect() {
            sendMessage("DISCONNECT:");
        }

        public void sendMatch() {
            sendMessage("MATCH:" + user.getPreferBoardSize());
        }

        public void sendJoin(String username) {
            sendMessage("JOIN:" + username);
        }

        public void sendLogin(String username, String password) {
            if (!username.isEmpty() && !password.isEmpty()) {
                password = encryptPassword(password);
                sendMessage("LOGIN:" + username + " " + password);
            } else showDialog("Login Failed", "No username or password provided!");
        }

        public void sendLogout() {
            sendMessage("LOGOUT:");
            switchToLRGUI();
            user = null;
        }

        public void sendRegister(String username, String password) {
            if (!username.isEmpty() && !password.isEmpty()) {
                password = encryptPassword(password);
                sendMessage("REGISTER:" + username + " " + password);
            } else showDialog("Register Failed", "No username or password provided!");
        }

        private void sendCancelMatching() {
            sendMessage("CANCEL_MATCHING:");
        }

        private void sendCancelWaiting() {
            sendMessage("CANCEL_WAITING:");
        }

        public void sendMove(String move) {
            controller.setCurrentMovingPlayer(controller.getOpponent());
            sendMessage("MOVE:" + move);
        }

        public void sendOver() {
            boolean hasRemaining = controller.getGameSession().getRemainingPairs() != 0;
            sendMessage("OVER:" + hasRemaining + " " + user.getUsername() + " " + user.getMistakes() + " " + controller.getOpponent().getUsername() + " " + controller.getOpponent().getMistakes() + " " + controller.getGameSession().getBoardSize());
        }

        public void sendQuery(String username) {
            sendMessage("QUERY:" + username);
        }

        public void sendRefresh() {
            sendMessage("REFRESH:");
        }

        public void sendUserMistakes(int mistake) {
            try {
                out.writeObject(mistake);
                out.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        private void sendMessage(String message) {
            try {
                out.writeObject(message);
                out.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    private class DataReceiver {

        private final ObjectInputStream in;

        private DataReceiver(Socket socket) throws IOException {
            in = new ObjectInputStream(socket.getInputStream());
        }

        private void handleServerOutput() throws IOException, ClassNotFoundException, InterruptedException {
            Object object = in.readObject();
            if (object != null) switch (object.getClass().getSimpleName()) {
                case "String" -> handleServerData((String) object);
                case "User" -> handleServerData((User) object);
                case "GameSession" -> handleServerData((GameSession) object);
                case "ArrayList" -> handleServerData((List<GameRecord>) object);
                case "Object[]" -> handlerServerData((Object[]) object);
            }
        }

        private void handlerServerData(Object[] object) {
            if (controller instanceof UserController && user != null) {
                List<User> users = (List<User>) object[0];
                Set<String> onlineUsers = (Set<String>) object[1];
                Set<String> matchingUsers = (Set<String>) object[2];
                String[] showUsersInfo = new String[users.size()];

                for (int i = 0; i < showUsersInfo.length; i++) {
                    if (users.get(i).getUsername().equals(user.getUsername())) continue;
                    boolean online = onlineUsers.contains(users.get(i).getUsername());
                    boolean matching = matchingUsers.contains(users.get(i).getUsername());
                    showUsersInfo[i] = "Username: " + users.get(i).getUsername() + " | Online: " + online + " | Matching: " + matching;
                }

                controller.showUser(showUsersInfo);
            }
        }

        private void handleServerData(GameSession gameSession) {
            if (!gameSession.isStarted()) {
                gameSession.getUser1().setMistakes(0);
                gameSession.getUser2().setMistakes(0);
            }

            if (controller instanceof GameController) {
                inGame = true;
                if (waitingDialog != null) Platform.runLater(() -> {
                    waitingDialog.close();
                    waitingDialog = null;
                });

                controller.setCurrentMovingPlayer(controller.getUser());
                controller.setGameSession(gameSession);
                controller.updateGameGUI();
            } else switchToGameGUI(gameSession);
        }

        private void handleServerData(String message) throws InterruptedException, IOException {
            String head = message.split(":")[0];
            String body = message.split(":")[1];
            switch (head) {
                case "LOGIN_SUCCESS", "WIN", "LOSE" -> {
                    showDialog(head, body);
                    switchSceneToUserGUI();
                    Thread.sleep(1000);
                }
                case "LOGOUT" -> {
                    showDialog(head, body);
                    switchToLRGUI();
                }
                case "WAITING" -> showDialog();
                case "MOVE" -> {
                    if (controller.isInvalidMove(body))
                        showDialog("MOVE FAILED", "It is a invalid link. Your opponent moved failed!");
                    controller.setCurrentMovingPlayer(controller.getUser());
                }
                case "OPPONENT_LEAVING" -> showDialog(body);
                case "OPPONENT_RECONNECTION" -> {
                    dataSender.out.writeObject(controller.getGameSession());
                    dataSender.out.flush();
                }
                default -> showDialog(head, body);
            }
        }

        private void handleServerData(User user) {
            GameClient.this.user = user;
        }

        private void handleServerData(List<GameRecord> gameRecords) {
            showDialog(gameRecords);
        }

        private void startServerListener() {
            executorService.submit(() -> {
                try {
                    while (!socket.isClosed()) handleServerOutput();
                } catch (IOException | ClassNotFoundException e) {
                    e.printStackTrace();
                    showDialog("SERVER CLOSED", "Server closed with exception! Wait and try again!\nThese dialogs will close in 3 seconds");
                    try {
                        Thread.sleep(3000);
                    } catch (InterruptedException ex) {
                        throw new RuntimeException(ex);
                    }
                    System.exit(0);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            });
        }
    }

    public static void main(String[] args) {
        launch();
    }
}
