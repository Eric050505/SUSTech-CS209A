package com.example.Service;

import com.example.DTO.ErrorDTO;
import com.example.DTO.QuestionDTO;
import com.example.DTO.TagDTO;
import com.example.Mapper.QuestionMapper;
import com.example.Model.Question;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.core.type.TypeReference;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class QuestionService {

    private final QuestionMapper questionMapper;

    public List<TagDTO> getTopNTags(int n) {
        return questionMapper.getTopNTags(n);
    }

    public List<TagDTO> getTopByUser(int n) {
        return questionMapper.getTopByUser(n);
    }

    public List<ErrorDTO> getTopNErrors(int n) {
        List<String> errorKeywords = Arrays.asList(
                "NullPointerException", "ArrayIndexOutOfBoundsException",
                "ClassNotFoundException", "IllegalArgumentException",
                "OutOfMemoryError", "StackOverflowError",
                "IOException", "FileNotFoundException",
                "ArithmeticException", "NumberFormatException",
                "InterruptedException", "IllegalStateException",
                "NoSuchElementException", "UnsupportedOperationException",
                "ConcurrentModificationException", "SecurityException",
                "AssertionError", "ClassCastException", "SQLException",
                "MalformedURLException", "IndexOutOfBoundsException",
                "IllegalAccessException", "InstantiationException",
                "NoClassDefFoundError", "UnsatisfiedLinkError",
                "IllegalMonitorStateException", "EOFException",
                "BindException", "SocketTimeoutException", "UnknownHostException",
                "AbstractMethodError", "AssertionError",
                "BootstrapMethodError", "ClassCircularityError",
                "ClassFormatError", "ExceptionInInitializerError",
                "IncompatibleClassChangeError", "InternalError",
                "LinkageError", "NoSuchFieldError",
                "NoSuchMethodError", "OutOfMemoryError",
                "StackOverflowError", "ThreadDeath",
                "UnknownError", "UnsatisfiedLinkError",
                "VerifyError", "VirtualMachineError",
                "ServiceConfigurationError", "LinkageError",
                "OutOfMemoryError", "ThreadDeath",
                "StackOverflowError", "ZipError", "UnknownError"
        );

        List<Map<String, Object>> results = questionMapper.getAllQuestions_quicker();
        Map<String, Integer> errorFrequency = new HashMap<>(); // 统计错误出现的次数
        Pattern pattern = Pattern.compile(String.join("|", errorKeywords), Pattern.CASE_INSENSITIVE);

        for (Map<String, Object> row : results) {
            Integer questionId = (Integer) row.get("question_id");
            String title = (String) row.get("title");
            String body = (String) row.get("body");
            String answers = questionMapper.getAnswersByQuestionId(questionId);
            String content = title + " " + body + " " + answers;
            Matcher matcher = pattern.matcher(content);
            while (matcher.find()) {
                String matchedError = matcher.group();
                for (String keyword : errorKeywords) {
                    if (matchedError.equalsIgnoreCase(keyword)) {
                        errorFrequency.put(keyword, errorFrequency.getOrDefault(keyword, 0) + 1);
                        break; // 匹配到一个关键词后即可停止继续匹配
                    }
                }
            }
        }

        // 将错误频率排序并限制到前 N 个
        List<Map.Entry<String, Integer>> sortedErrors = new ArrayList<>(errorFrequency.entrySet());
        sortedErrors.sort((a, b) -> b.getValue().compareTo(a.getValue()));

        // 转换为 DTO 列表
        List<ErrorDTO> topErrors = new ArrayList<>();
        for (int i = 0; i < Math.min(n, sortedErrors.size()); i++) {
            Map.Entry<String, Integer> entry = sortedErrors.get(i);
            topErrors.add(new ErrorDTO(entry.getKey(), entry.getValue()));
        }
        return topErrors;
    }



}
