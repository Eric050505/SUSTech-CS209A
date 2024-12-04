package com.example.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "comments")
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer commentId;
    private Integer postId;
    private String postType;
    private String body;

    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    private Integer score;
    private Integer ownerUserId;

}
