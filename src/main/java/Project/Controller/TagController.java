package Project.Controller;

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
@RequestMapping("/tags")
public class TagController {

    private final QuestionService questionService;

    @GetMapping("/TopTopics")
    public List<TagDTO> getTopNTags(@RequestParam int n) {
        return questionService.getTopNTags(n);
    }

    @GetMapping("/HighRepUserTags")
    public List<TagDTO> getTopByUser(@RequestParam int n) {
        return questionService.getTopByUser(n);
    }
}