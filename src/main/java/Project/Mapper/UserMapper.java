package Project.Mapper;

import Project.Model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {
    @Select("SELECT * from Users WHERE user_id = #{id}")
    User getUserById(@Param("id") Integer id);
}
