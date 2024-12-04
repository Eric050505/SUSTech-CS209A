package com.example.Controller;

import com.example.DTO.AnswerDTO;
import com.example.Service.AnswerService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/answers")
public class AnswerController {
    private final AnswerService answerService;

    @GetMapping()
    public AnswerDTO getAnswerById(@RequestParam int answerId) {
        return answerService.getAnswerById(answerId);
    }

}
