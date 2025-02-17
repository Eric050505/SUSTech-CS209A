package Project.Controller;


import Project.DTO.AnswerDTO;
import Project.DTO.SectionsDTO;
import Project.Service.AnswerService;
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

    @GetMapping("/SecUserPoints")
    public List<SectionsDTO> getSecUserPoints(@RequestParam int n, @RequestParam int x) {
        return answerService.getSecUserPoints(n, x);
    }

}
