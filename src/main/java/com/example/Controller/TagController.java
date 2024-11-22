package com.example.Controller;

import com.example.DTO.TagDTO;
import com.example.Service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/tags")
public class TagController {

    @Autowired
    private TagService tagService;

    @GetMapping("/getTopN")
    public List<TagDTO> getTopNTags(@RequestParam int n) {
        System.out.println(56565); // 调试输出
        List<TagDTO> tags = tagService.getTopNTags(n);
        for (TagDTO tag : tags) {
            System.out.println(tag); // 调用 toString() 方法，检查数据内容
        }
        return tags;

    }
}
