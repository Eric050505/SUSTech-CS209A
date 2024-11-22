package com.example.Service;

import com.example.DTO.TagDTO;
import com.example.Mapper.TagMapper;
import com.example.Model.TagCount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TagService {

    @Autowired
    private TagMapper tagMapper;

    public List<TagDTO> getTopNTags(int n) {
        // 获取所有标签及其热度
        List<TagCount> tagCounts = tagMapper.getAllTagCounts();

        // 按热度降序排序并获取前 n 个标签
        return tagCounts.stream()
                .sorted((a, b) -> Integer.compare(b.getHot(), a.getHot()))
                .limit(n)
                .map(tagCount -> new TagDTO(tagCount.getTopic(), tagCount.getHot()))
                .collect(Collectors.toList());
    }
}
