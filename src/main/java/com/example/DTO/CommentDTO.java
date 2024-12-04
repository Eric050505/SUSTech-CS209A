package com.example.DTO;

import com.example.Model.Comment;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CommentDTO {
    private Integer commentId;
    private Integer postId;
    private POST_TYPE postType;
    private String body;
    private Date creationDate;
    private Integer score;
    private Integer ownerUserId;

    public CommentDTO(Comment comment) {
        this.commentId = comment.getCommentId();
        this.postId = comment.getPostId();
        this.postType = POST_TYPE.fromString(comment.getPostType());
        this.body = comment.getBody();
        this.creationDate = comment.getCreationDate();
        this.score = comment.getScore();
        this.ownerUserId = comment.getOwnerUserId();
    }
}
