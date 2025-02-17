package Assignment.Assignment2.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.io.Serializable;
import java.util.Date;

@AllArgsConstructor
@Getter
public class GameRecord implements Serializable {
    private String opponent;
    private boolean win;
    private Date date;
}
