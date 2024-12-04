package com.example.DTO;

import com.example.Model.Question;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
public class QuestionDTO {
    private Integer questionId;
    private String title;
    private String body;
    private List<String> tags;
    private Date creationDate;
    private Date lastActivityDate;
    private Integer viewCount;
    private Integer answerCount;
    private Integer commentCount;
    private Integer ownerUserId;
    private Integer acceptedAnswerId;

    public QuestionDTO(Question question, List<String> tags) {
        this.questionId = question.getQuestionId();
        this.title = question.getTitle();
        this.body = question.getBody();
        this.tags = tags;
        this.creationDate = question.getCreationDate();
        this.lastActivityDate = question.getLastActivityDate();
        this.viewCount = question.getViewCount();
        this.answerCount = question.getAnswerCount();
        this.commentCount = question.getCommentCount();
        this.ownerUserId = question.getOwnerUserId();
        this.acceptedAnswerId = question.getAcceptedAnswerId();
    }
}
