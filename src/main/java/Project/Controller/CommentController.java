package Project.Controller;

import Project.DTO.CommentDTO;
import Project.Service.CommentService;
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
