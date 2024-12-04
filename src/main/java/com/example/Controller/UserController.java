package com.example.Controller;

import com.example.DTO.UserDTO;
import com.example.Service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/users")
public class UserController {
    private final UserService userService;

    @GetMapping()
    public UserDTO getUserById(@RequestParam Integer userId) throws JsonProcessingException {
        return userService.getUserById(userId);
    }

}
