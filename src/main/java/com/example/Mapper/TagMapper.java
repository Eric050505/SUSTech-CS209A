package com.example.Mapper;

import com.example.Model.TagCount;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TagMapper {

    @Select("""
            SELECT tag, COUNT(*) AS hot
            FROM Questions, 
                 JSON_TABLE(tags, '$[*]' COLUMNS(tag VARCHAR(255) PATH '$')) AS tag_table
            GROUP BY tag
            ORDER BY hot DESC
            """)
    List<TagCount> getAllTagCounts();
}
