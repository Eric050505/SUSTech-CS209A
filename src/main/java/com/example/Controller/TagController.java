package com.example.Controller;

import com.example.DTO.TagDTO;
import com.example.Service.QuestionService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/tags")
public class TagController {

    private final QuestionService questionService;

    @GetMapping("/getTopN")
    public List<TagDTO> getTopNTags(@RequestParam int n) {
        return questionService.getTopNTags(n);
    }

    @GetMapping("/getTopByUser")
    public List<TagDTO> getTopByUser(@RequestParam int n) {
        return questionService.getTopByUser(n);
    }
}