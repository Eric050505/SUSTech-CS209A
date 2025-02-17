package Project.Mapper;

import Project.Model.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CommentMapper {
    @Select("SELECT * from Comments WHERE comment_id = #{id}")
    Comment getCommentById(@Param("id") Integer id);

}
