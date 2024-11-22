package com.example.Service;

import com.example.DTO.QuestionDTO;
import com.example.Mapper.QuestionMapper;
import com.example.Model.Question;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class QuestionService {

    private final QuestionMapper questionMapper;
    private final ObjectMapper objectMapper;

    @Autowired
    public QuestionService(QuestionMapper questionMapper, ObjectMapper objectMapper) {
        this.questionMapper = questionMapper;
        this.objectMapper = objectMapper;
    }

    public QuestionDTO getQuestionById(Integer id) throws JsonProcessingException {
        Question question = questionMapper.getQuestionById(id);
        List<String> tags = objectMapper.readValue(question.getTags(), new TypeReference<>() {
        });
        return new QuestionDTO(question, tags);
    }

    public List<QuestionDTO> getAll() throws JsonProcessingException {
        List<Question> questions = questionMapper.getAll();
        List<QuestionDTO> questionsDTO = new ArrayList<>();

        for (Question question : questions) {
            List<String> tag = objectMapper.readValue(question.getTags(), new TypeReference<>() {});
            questionsDTO.add(new QuestionDTO(question, tag));
        }

        return questionsDTO;
    }
}
