package com.example.Model;

import lombok.Getter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "answers")
@Getter
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer answerID;
    private Integer questionID;
    private String body;

    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    private Integer score;
    private Boolean isAccepted;
    private Integer ownerUserId;

}
