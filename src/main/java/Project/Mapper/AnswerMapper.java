package Project.Mapper;

import Project.Model.Answer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface AnswerMapper {
    @Select("SELECT * from Answers WHERE answer_id = #{id}")
    Answer getAnswerById(@Param("id") Integer id);

    @Select("SELECT MAX(reputation) FROM Users")
    int getMaxReputation();

    @Select("""
            SELECT AVG(a.score)
            FROM Users u
            JOIN Answers a
            ON u.user_id = a.owner_user_id
            WHERE u.reputation BETWEEN #{front} AND #{back};
            """)
   float getAverageScore(@Param("front") Integer front, @Param("back") Integer back);

}
