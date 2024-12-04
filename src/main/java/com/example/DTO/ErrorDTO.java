package com.example.DTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class ErrorDTO {
    private String ErrorMessage;
    private int hot;
}
