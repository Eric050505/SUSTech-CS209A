package com.example.Controller;

import com.example.DTO.AnswerDTO;
import com.example.DTO.SectionsDTO;
import com.example.Service.AnswerService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/answers")
public class AnswerController {
    private final AnswerService answerService;

    @GetMapping()
    public AnswerDTO getAnswerById(@RequestParam int answerId) {
        return answerService.getAnswerById(answerId);
    }

    @GetMapping("/getSecUserPoints")
    public List<SectionsDTO> getSecUserPoints(@RequestParam int n,@RequestParam int x) {
        return answerService.getSecUserPoints(n, x);
    }

    @GetMapping("/getSecAnsTime")
    public List<SectionsDTO> getSecAnsTime(@RequestParam int n,@RequestParam int x) {
        return answerService.getSecAnsTime(n, x);
    }

    @GetMapping("/getSecAnsLength")
    public List<SectionsDTO> getSecAnsLength(@RequestParam int n,@RequestParam int x) {
        return answerService.getSecAnsLength(n, x);
    }



}
