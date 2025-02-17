package Project.Service;

import Project.DTO.CommentDTO;
import Project.Mapper.CommentMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class CommentService {
    private CommentMapper commentMapper;

    public CommentDTO getCommentById(int id) {
        return new CommentDTO(commentMapper.getCommentById(id));
    }
}
