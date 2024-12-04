package com.example.DTO;

import com.example.Model.Answer;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AnswerDTO {
    private Integer answerID;
    private Integer questionID;
    private String body;
    private Date creationDate;
    private Integer score;
    private Boolean isAccepted;
    private Integer ownerUserId;

    public AnswerDTO(Answer answer) {
        this.answerID = answer.getAnswerID();
        this.questionID = answer.getQuestionID();
        this.body = answer.getBody();
        this.creationDate = answer.getCreationDate();
        this.score = answer.getScore();
        this.isAccepted = answer.getIsAccepted();
        this.ownerUserId = answer.getOwnerUserId();
    }
}
