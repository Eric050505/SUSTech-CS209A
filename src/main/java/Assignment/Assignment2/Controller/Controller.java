package Assignment.Assignment2.Controller;

import Assignment.Assignment2.GameClient;
import Assignment.Assignment2.Model.GameSession;
import Assignment.Assignment2.Model.User;

public abstract class Controller {
    public void updateGameGUI() {
    }

    public void setGameClient(GameClient gameClient) {
    }

    public void setGameSession(GameSession gameSession) {
    }

    public User getUser() {
        return null;
    }

    public void setUser(User user) {
    }

    public void setOpponent(User currentUser) {
    }

    public User getOpponent() {
        return null;
    }

    public void setCurrentMovingPlayer(User currentMovingPlayer) {
    }

    public boolean isInvalidMove(String moveContent) {
        return true;
    }

    public GameSession getGameSession() {
        return null;
    }

    public void showUser(String[] userInfo) {

    }
}
