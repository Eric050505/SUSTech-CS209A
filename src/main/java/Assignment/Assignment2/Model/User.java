package Assignment.Assignment2.Model;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
public class User implements Serializable {
    private final String username;
    private final String password;
    @Setter
    private int mistakes;
    @Setter
    private int preferBoardSize;
    private final List<GameRecord> gameRecords = new ArrayList<>();

    public User(String username, String password) {
        this.username = username;
        this.password = password;
        this.mistakes = 0;
    }

    public void addMistake() {
        mistakes++;
    }

}
