package com.example.Mapper;

import com.example.Model.Answer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface AnswerMapper {
    @Select("SELECT * from Answers WHERE answer_id = #{id}")
    Answer getAnswerById(@Param("id") Integer id);

    // -- 问题四：回答质量探究：回答时间差、回答者积分、回答长度
    @Select("SELECT MAX(reputation) FROM Users")
    int getMaxReputation();

    @Select("""
            SELECT AVG(a.score)
            FROM Users u
            JOIN Answers a
            ON u.user_id = a.owner_user_id
            WHERE u.reputation BETWEEN #{front} AND #{back};
            """)
    float getAverageScore(Integer front,Integer back);


    @Select("""
        SELECT MAX(TIMESTAMPDIFF(HOUR, q.creation_date, a.creation_date)) AS max_time_diff
        FROM Answers a
        JOIN Questions q
        ON a.question_id = q.question_id;
        """)
    int getMaxTimeDiff();

    @Select("""
        SELECT AVG(a.score)
        FROM Answers a
        JOIN Questions q
        ON a.question_id = q.question_id
        WHERE TIMESTAMPDIFF(HOUR, q.creation_date, a.creation_date) BETWEEN #{front} AND #{back};
        """)
    float getAverageScore_time(Integer front, Integer back);


    @Select("""
        SELECT MAX(LENGTH(body)) AS max_length
        FROM Answers;
        """)
    int getLongestAnswerLength();

    @Select("""
        SELECT AVG(a.score)
        FROM Answers a
        WHERE LENGTH(a.body) BETWEEN #{front} AND #{back};
        """)
    float getAverageScore_Length(Integer front, Integer back);
}
