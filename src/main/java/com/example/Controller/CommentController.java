package com.example.Controller;

import com.example.DTO.CommentDTO;
import com.example.Service.CommentService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/comments")
public class CommentController {
    private final CommentService commentService;

    @GetMapping()
    public CommentDTO getCommentById(@RequestParam Integer commentId) {
        return commentService.getCommentById(commentId);
    }
}
