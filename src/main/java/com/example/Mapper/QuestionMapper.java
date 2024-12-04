package com.example.Mapper;

import com.example.DTO.TagDTO;
import com.example.Model.Question;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface QuestionMapper {

    @Select("SELECT * from Questions WHERE question_id = #{id}")
    Question getQuestionById(@Param("id") Integer id);

    @Select("""
             SELECT tag, COUNT(*) AS hot
             FROM Questions,
                  JSON_TABLE(tags, '$[*]' COLUMNS(tag VARCHAR(255) PATH '$')) AS tag_table
             GROUP BY tag
             ORDER BY hot DESC
             LIMIT #{n}
            """)
    List<TagDTO> getTopNTags(int n);


    @Select("SELECT title, body FROM Questions")
    List<Map<String, String>> getAllQuestions();

    @Select("SELECT question_id FROM Questions WHERE title = #{title}")
    int getQuestionsIdByTitle (String title);

    @Select("SELECT GROUP_CONCAT(body SEPARATOR ' ') AS concatenated_answers FROM Answers WHERE question_id = #{questionId}")
    String getAnswersByQuestionId(Integer questionId);


}
