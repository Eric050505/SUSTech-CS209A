package com.example.Service;

import com.example.DTO.CommentDTO;
import com.example.Mapper.CommentMapper;
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
