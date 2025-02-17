package Project.Service;


import Project.DTO.UserDTO;
import Project.Mapper.UserMapper;
import Project.Model.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class UserService {

    private final UserMapper userMapper;
    private final ObjectMapper objectMapper;

    public UserDTO getUserById(Integer id) throws JsonProcessingException {
        User user = userMapper.getUserById(id);
        if (!user.getBadgeCounts().equals("{}")) {
            List<String> badgeCounts = objectMapper.readValue(user.getBadgeCounts(), new TypeReference<>() {
            });
            return new UserDTO(user, badgeCounts);
        }
        return new UserDTO(user, null);
    }

}
