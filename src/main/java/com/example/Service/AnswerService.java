package com.example.Service;

import com.example.DTO.AnswerDTO;
import com.example.Mapper.AnswerMapper;
import com.example.Model.Answer;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class AnswerService {

    private final AnswerMapper answerMapper;

    public AnswerDTO getAnswerById(int id) {
        Answer answer = answerMapper.getAnswerById(id);
        return new AnswerDTO(answer);
    }
}
