package com.example.Controller;

import com.example.DTO.ErrorDTO;
import com.example.DTO.QuestionDTO;
import com.example.DTO.TagDTO;
import com.example.Service.QuestionService;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/questions")
public class QuestionController {

    private final QuestionService questionService;

    @GetMapping("/Errors")
    public List<ErrorDTO> getTopNErrors(@RequestParam Integer n) {
        return questionService.getTopNErrors(n);
    }

    @GetMapping("/TagFrequency")
    public TagDTO getTagFrequency(@RequestParam String tag) {
        return questionService.getTagFrequency(tag);
    }
}
