package com.example.Mapper;

import com.example.Model.Answer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface AnswerMapper {
    @Select("SELECT * from Answers WHERE answer_id = #{id}")
    Answer getAnswerById(@Param("id") Integer id);

}
