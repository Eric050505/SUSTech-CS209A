package Project.Controller;

import Project.DTO.ErrorDTO;
import Project.DTO.TagDTO;
import Project.Service.QuestionService;
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

    @GetMapping("/TopErrors")
    public List<ErrorDTO> getTopNErrors(@RequestParam Integer n) {
        return questionService.getTopNErrors(n);
    }

    @GetMapping("/TagFrequency")
    public TagDTO getTagFrequency(@RequestParam String tag) {
        return questionService.getTagFrequency(tag);
    }

    @GetMapping("/ErrorFrequency")
    public ErrorDTO getErrorFrequency(@RequestParam String error) {
        return questionService.getErrorFrequency(error);
    }
}
