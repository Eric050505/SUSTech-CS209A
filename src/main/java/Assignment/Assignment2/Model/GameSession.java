package Assignment.Assignment2.Model;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Getter
public class GameSession implements Serializable {
    @Setter
    private User user1;
    @Setter
    private User user2;
    private final int[][] gameBoard;
    private int remainingPairs;
    private final int boardSize;
    private boolean started;

    public GameSession(User user1, User user2, int boardSize) {
        this.user1 = user1;
        this.user2 = user2;
        this.boardSize = boardSize;
        this.gameBoard = new int[boardSize + 2][boardSize + 2];
        this.started = false;
        while (hasNoLink()) initialBoard();
    }

    public boolean hasNoLink() {
        for (int x1 = 0; x1 < boardSize + 2; x1++)
            for (int y1 = 0; y1 < boardSize + 2; y1++)
                for (int x2 = 0; x2 < boardSize + 2; x2++)
                    for (int y2 = 0; y2 < boardSize + 2; y2++)
                        if ((x1 != x2 || y1 != y2) && gameBoard[x1][y1] == gameBoard[x2][y2] && gameBoard[x1][y1] != 0) {
                            List<int[]> path = new ArrayList<>();
                            if (linkNoTurn(x1, y1, x2, y2, path) || linkOneTurn(x1, y1, x2, y2, path) || linkTwoTurn(x1, y1, x2, y2, path))
                                return false;
                        }
        return true;
    }

    private void initialBoard() {
        List<Integer> remainIcons = new ArrayList<>();
        if (boardSize < 6)
            for (int i = 0; i < boardSize * boardSize / 2; i++) {
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
            }
        else if (boardSize == 6)
            for (int i = 0; i < boardSize * boardSize / 4; i++) {
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
            }
        else
            for (int i = 0; i < boardSize * boardSize / 8; i++) {
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
                remainIcons.add(i + 1);
            }
        Collections.shuffle(remainIcons);

        int[][] innerBoard = new int[boardSize][boardSize];
        for (int i = 0; i < boardSize; i++)
            for (int j = 0; j < boardSize; j++)
                innerBoard[i][j] = remainIcons.remove(0);

        for (int i = 0; i < gameBoard.length; i++)
            for (int j = 0; j < gameBoard[i].length; j++)
                if (i == 0 || i == gameBoard.length - 1 || j == 0 || j == gameBoard[i].length - 1) gameBoard[i][j] = 0;
                else gameBoard[i][j] = innerBoard[i - 1][j - 1];
        remainingPairs = boardSize * boardSize / 2;
    }

    public List<int[]> linkPath(int x1, int y1, int x2, int y2) {
        started = true;
        List<int[]> path = new ArrayList<>();
        if (gameBoard[x1][y1] != gameBoard[x2][y2]) return path;
        if (linkNoTurn(x1, y1, x2, y2, path) || linkOneTurn(x1, y1, x2, y2, path) || linkTwoTurn(x1, y1, x2, y2, path)) {
            gameBoard[x1][y1] = 0;
            gameBoard[x2][y2] = 0;
            remainingPairs--;
            return path;
        }
        return new ArrayList<>();
    }

    private boolean linkNoTurn(int x1, int y1, int x2, int y2, List<int[]> path) {
        if (x1 == x2 && isClearY(x1, y1, y2)) {
            addPath(x1, y1, x2, y2, path);
            return true;
        }
        if (y1 == y2 && isClearX(x1, x2, y1)) {
            addPath(x1, y1, x2, y2, path);
            return true;
        }
        return false;
    }

    private boolean linkOneTurn(int x1, int y1, int x2, int y2, List<int[]> path) {
        if (gameBoard[x2][y1] == 0 && isClearX(x1, x2, y1) && isClearY(x2, y1, y2)) {
            addPath(x1, y1, x2, y1, path);
            addPath(x2, y1, x2, y2, path);
            return true;
        }
        if (gameBoard[x1][y2] == 0 && isClearY(x1, y1, y2) && isClearX(x1, x2, y2)) {
            addPath(x1, y1, x1, y2, path);
            addPath(x1, y2, x2, y2, path);
            return true;
        }
        return false;
    }

    private boolean linkTwoTurn(int x1, int y1, int x2, int y2, List<int[]> path) {
        for (int[] position : getEmptyPositions(x1, y1)) {
            List<int[]> tempPath = new ArrayList<>(path);
            if (linkOneTurn(position[0], position[1], x2, y2, tempPath)) {
                addPath(x1, y1, position[0], position[1], path);
                path.addAll(tempPath);
                return true;
            }
        }
        return false;
    }

    private void addPath(int x1, int y1, int x2, int y2, List<int[]> path) {
        if (x1 == x2) {
            for (int y = Math.min(y1, y2); y <= Math.max(y1, y2); y++)
                path.add(new int[]{x1, y});
        } else if (y1 == y2) {
            for (int x = Math.min(x1, x2); x <= Math.max(x1, x2); x++)
                path.add(new int[]{x, y1});
        }
    }

    private List<int[]> getEmptyPositions(int i, int j) {
        List<int[]> emptyPositions = new ArrayList<>();
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int[] direction : directions) {
            int x = i + direction[0];
            int y = j + direction[1];

            while (x >= 0 && x < gameBoard.length && y >= 0 && y < gameBoard[0].length && gameBoard[x][y] == 0) {
                emptyPositions.add(new int[]{x, y});
                x += direction[0];
                y += direction[1];
            }
        }

        return emptyPositions;
    }

    private boolean isClearX(int x1, int x2, int y) {
        int start = Math.min(x1, x2);
        int end = Math.max(x1, x2);
        for (int row = start + 1; row < end; row++)
            if (gameBoard[row][y] != 0) return false;
        return true;
    }

    private boolean isClearY(int x, int y1, int y2) {
        int start = Math.min(y1, y2);
        int end = Math.max(y1, y2);
        for (int col = start + 1; col < end; col++)
            if (gameBoard[x][col] != 0) return false;
        return true;
    }

}
