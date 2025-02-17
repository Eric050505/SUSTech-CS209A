package Assignment.Assignment2.Controller;

import Assignment.Assignment2.GameClient;
import Assignment.Assignment2.Model.GameSession;
import Assignment.Assignment2.Model.User;
import Assignment.Assignment2.Renderer.CellRenderer;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.geometry.Bounds;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class GameController extends Controller {

    @FXML
    private Label mistakesLabel1;

    @FXML
    private Label mistakesLabel2;

    @FXML
    private Label currentPlayerLabel;

    @FXML
    private GridPane gridPane;

    @FXML
    private Pane linesPane;

    @Getter @Setter
    private GameSession gameSession;

    @Setter
    private GameClient gameClient;

    @Getter @Setter
    private User currentMovingPlayer;

    @Getter @Setter
    private User user;

    @Getter @Setter
    private User opponent;

    private final List<int[]> selectedCells = new ArrayList<>();

    public void updateGameGUI() {
        Platform.runLater(() -> {
            mistakesLabel1.setText(gameSession.getUser1().getUsername() + " Mistakes Count: " + gameSession.getUser1().getMistakes());
            mistakesLabel2.setText(gameSession.getUser2().getUsername() + " Mistakes Count: " + gameSession.getUser2().getMistakes());
            currentPlayerLabel.setText("Current Player: " + currentMovingPlayer.getUsername());
            gridPane.getChildren().clear();

            int[][] board = gameSession.getGameBoard();
            for (int i = 0; i < board.length; i++)
                for (int j = 0; j < board[i].length; j++) {
                    Button cellButton = getCell(board, i, j);
                    if (cellButton != null) gridPane.add(cellButton, j, i);
                }
        });
    }

    public boolean isInvalidMove(String moveContent) {
        boolean res = false;
        String[] parts = moveContent.split(",");
        int x1 = Integer.parseInt(parts[0]);
        int y1 = Integer.parseInt(parts[1]);
        int x2 = Integer.parseInt(parts[2]);
        int y2 = Integer.parseInt(parts[3]);

        List<int[]> path = gameSession.linkPath(x1, y1, x2, y2);

        if (path.isEmpty()) {
            currentMovingPlayer.addMistake();
            this.gameClient.getDataSender().sendUserMistakes(user.getMistakes());
            res = true;
        } else {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            Platform.runLater(() -> renderPath(path));
        }

        updateGameGUI();
        return res;
    }

    private void renderPath(List<int[]> path) {
        linesPane.getChildren().clear();
        for (int i = 0; i < path.size() - 1; i++) {
            int[] start = path.get(i);
            int[] end = path.get(i + 1);

            Node startNode = getNodeFromGridPane(gridPane, start[0], start[1]);
            Node endNode = getNodeFromGridPane(gridPane, end[0], end[1]);

            if (startNode == null || endNode == null) continue;
            Bounds startBounds = startNode.getBoundsInParent();
            Bounds endBounds = endNode.getBoundsInParent();
            double startX = startBounds.getMinX() + startBounds.getWidth() / 2;
            double startY = startBounds.getMinY() + startBounds.getHeight() / 2;
            double endX = endBounds.getMinX() + endBounds.getWidth() / 2;
            double endY = endBounds.getMinY() + endBounds.getHeight() / 2;

            Line line = new Line(startX, startY, endX, endY);
            line.setStroke(Color.RED);
            line.setStrokeWidth(3);

            linesPane.getChildren().add(line);
        }
    }

    private Node getNodeFromGridPane(GridPane gridPane, int row, int col) {
        for (Node node : gridPane.getChildren()) {
            if (GridPane.getRowIndex(node) != null && GridPane.getColumnIndex(node) != null && GridPane.getRowIndex(node) == row && GridPane.getColumnIndex(node) == col) {
                return node;
            }
        }
        return null;
    }

    private void handleCellClick(int i, int j) {
        if (gameSession.getGameBoard()[i][j] == 0) return;
        if (!currentMovingPlayer.equals(user)) {
            gameClient.showDialog("MOVE FAILED", "Now it is not your turn!");
            return;
        }

        int[] currentCell = new int[]{i, j};
        if (!selectedCells.isEmpty() && Arrays.equals(selectedCells.get(0), currentCell)) {
            selectedCells.clear();
            updateGameGUI();
        } else if (selectedCells.size() < 2) {
            selectedCells.add(currentCell);
            updateGameGUI();
        }

        if (selectedCells.size() == 2) {
            int[] cell1 = selectedCells.get(0);
            int[] cell2 = selectedCells.get(1);
            String moveContent = cell1[0] + "," + cell1[1] + "," + cell2[0] + "," + cell2[1];
            if (this.isInvalidMove(moveContent))
                gameClient.showDialog("MOVE FAILED", "It is a invalid link. You moved failed!");
            gameClient.getDataSender().sendMove(moveContent);
            selectedCells.clear();

            if ((gameSession.getRemainingPairs() == 0 && currentMovingPlayer == opponent) || gameSession.hasNoLink())
                gameClient.getDataSender().sendOver();
        }
    }

    private Button getCell(int[][] board, int i, int j) {
        if (i == 0 || j == 0 || i == board.length - 1 || j == board.length - 1) return null;
        int cellValue = board[i][j];
        ImageView imageView = CellRenderer.renderCell(cellValue);

        Button cellButton = new Button();
        HBox hBox = new HBox(imageView);
        hBox.setAlignment(Pos.CENTER);
        hBox.setPrefWidth(25);
        hBox.setPrefHeight(25);
        imageView.setFitWidth(hBox.getPrefWidth() * 0.8);
        imageView.setFitHeight(hBox.getPrefHeight() * 0.8);
        cellButton.setGraphic(hBox);
        cellButton.setStyle("-fx-border-color: black; -fx-alignment: center;");

        cellButton.setOnAction(e -> handleCellClick(i, j));

        if (!selectedCells.isEmpty() && Arrays.equals(selectedCells.get(0), new int[]{i, j})) {
            cellButton.setStyle("-fx-border-color: yellow; -fx-alignment: center; -fx-background-color: lightblue;");
        }

        return cellButton;
    }

}
