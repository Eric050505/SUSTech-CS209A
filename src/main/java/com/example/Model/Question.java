package com.example.Model;

import javax.persistence.*;
import java.util.Date;

import lombok.Getter;

@Entity
@Table(name = "questions")
@Getter
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer questionId;

    private String title;
    private String body;
    private String tags;

    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    @Temporal(TemporalType.TIMESTAMP)
    private Date lastActivityDate;

    private Integer viewCount;
    private Integer answerCount;
    private Integer commentCount;
    private Integer ownerUserId;
    private Integer acceptedAnswerId;

}
