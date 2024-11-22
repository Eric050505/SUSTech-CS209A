package com.example.Mapper;

import com.example.DTO.QuestionDTO;
import com.example.Model.Question;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface QuestionMapper {

    @Select("SELECT * from Questions WHERE question_id = #{id}")
    Question getQuestionById(@Param("id") Integer id);

    @Select("SELECT * from Questions")
    List<Question> getAll();

}
