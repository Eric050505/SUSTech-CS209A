package com.example.Controller;

import com.example.DTO.QuestionDTO;
import com.example.DTO.TagDTO;
import com.example.Service.QuestionService;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class QuestionController {

    private final QuestionService questionService;

    public QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @GetMapping("/questions")
    public QuestionDTO getQuestionsById(@RequestParam Integer id) throws JsonProcessingException {
        return questionService.getQuestionById(id);
    }

    @GetMapping("/getAll")
    public List<QuestionDTO> getAll() throws JsonProcessingException {

        return questionService.getAll();
    }

}
