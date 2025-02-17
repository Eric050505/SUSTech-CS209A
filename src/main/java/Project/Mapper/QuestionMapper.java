package Project.Mapper;

import Project.DTO.TagDTO;
import Project.Model.Question;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
             LIMIT #{n} OFFSET 1;
            """)
    List<TagDTO> getTopNTags(int n);

    @Select("""
            WITH HighRepUserEngageTags AS (
                WITH HighReputationUsers AS (
                    SELECT user_id
                    FROM users
                    WHERE reputation > 1000
                )
                SELECT q.tags AS tag,
                       (COUNT(DISTINCT c.comment_id) +
                        COUNT(DISTINCT a.answer_id) +
                        COUNT(DISTINCT ac.comment_id)) AS total_engagement
                FROM questions q
                LEFT JOIN answers a ON q.question_id = a.question_id
                LEFT JOIN comments c ON q.question_id = c.post_id AND c.post_type = 'question'
                LEFT JOIN comments ac ON a.answer_id = ac.post_id AND ac.post_type = 'answer'
                LEFT JOIN HighReputationUsers hr ON hr.user_id = c.owner_user_id
                LEFT JOIN HighReputationUsers hr2 ON hr2.user_id = a.owner_user_id
                LEFT JOIN HighReputationUsers hr3 ON hr3.user_id = ac.owner_user_id
                GROUP BY q.question_id, q.tags
            )
            SELECT weighted_tag, SUM(total_engagement) AS hot
            FROM HighRepUserEngageTags,
                 JSON_TABLE(tag, '$[*]' COLUMNS(weighted_tag VARCHAR(255) PATH '$')) AS tag_table
            GROUP BY weighted_tag
            ORDER BY hot DESC
            LIMIT #{n} OFFSET 1;
            """)
    List<TagDTO> getTopByUser(@Param("n") Integer n);

    @Select("SELECT GROUP_CONCAT(body SEPARATOR ' ') AS concatenated_answers FROM Answers WHERE question_id = #{questionId}")
    String getAnswersByQuestionId(Integer questionId);

    @Select("SELECT question_id, title, body FROM Questions")
    List<Map<String, Object>> getAllQuestions();

    @Select("""
            SELECT jt.tag, COUNT(*) as frequency
            FROM Questions,
            JSON_TABLE(tags, '$[*]' COLUMNS (tag VARCHAR(255) PATH '$')) as jt
            WHERE tag = #{tag};
            """)
    TagDTO getTopicFrequency(String tag);

}
