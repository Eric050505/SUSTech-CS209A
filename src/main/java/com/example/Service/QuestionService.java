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
    private final ObjectMapper objectMapper;

//    public QuestionDTO getQuestionById(Integer id) throws JsonProcessingException {
//        Question question = questionMapper.getQuestionById(id);
//        List<String> tags = objectMapper.readValue(question.getTags(), new TypeReference<>() {
//        });
//        return new QuestionDTO(question, tags);
//    }

    public List<TagDTO> getTopNTags(int n) {
        return questionMapper.getTopNTags(n);
    }

    public List<TagDTO> getTopByUser(int n) {
        return questionMapper.getTopByUser(n);
    }

    public List<ErrorDTO> getTopNErrors(int n) {

        List<Map<String, String>> questions = questionMapper.getAllQuestions();
        List<String> errorKeywords = Arrays.asList(
                // 常见异常
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

                // 系统错误（Error）
                "AbstractMethodError", // 抽象方法未实现错误
                "AssertionError", // 断言失败错误
                "BootstrapMethodError", // JVM 引导方法错误
                "ClassCircularityError", // 类循环依赖错误
                "ClassFormatError", // 类文件格式错误
                "ExceptionInInitializerError", // 静态初始化块中抛出异常
                "IncompatibleClassChangeError", // 类不兼容更改错误
                "InternalError", // JVM 内部错误
                "LinkageError", // 链接错误
                "NoSuchFieldError", // 字段不存在错误
                "NoSuchMethodError", // 方法不存在错误
                "OutOfMemoryError", // 内存不足错误
                "StackOverflowError", // 栈溢出错误
                "ThreadDeath", // 线程结束错误（已过时）
                "UnknownError", // 未知错误
                "UnsatisfiedLinkError", // 本地方法库链接错误
                "VerifyError", // 字节码验证错误
                "VirtualMachineError", // 虚拟机错误
                "ServiceConfigurationError", // 服务配置错误
                "LinkageError", // 链接类文件错误
                "OutOfMemoryError", // 堆内存不足
                "ThreadDeath", // 线程被强制终止
                "StackOverflowError", // 方法调用栈溢出
                "ZipError", // 压缩格式错误
                "UnknownError" // 未知错误
        );

        Map<String, Integer> errorFrequency = new HashMap<>(); // 统计错误出现的次数
        // 正则表达式匹配错误关键词
        Pattern pattern = Pattern.compile(String.join("|", errorKeywords), Pattern.CASE_INSENSITIVE);
        for (Map<String, String> question : questions) {
            int id = questionMapper.getQuestionsIdByTitle(question.get("title"));
            //获取回答
            String answers = questionMapper.getAnswersByQuestionId(id);

            // 获取问题的标题和正文
            String content = question.get("title") + " " + question.get("body") + " " + answers;

            // 匹配错误关键词
            Matcher matcher = pattern.matcher(content);
            while (matcher.find()) {
                String matchedError = matcher.group(); // 匹配到的错误文本
                for (String keyword : errorKeywords) {
                    if (matchedError.equalsIgnoreCase(keyword)) { // 比较是否匹配关键词
                        errorFrequency.put(keyword, errorFrequency.getOrDefault(keyword, 0) + 1);
                        break; // 匹配到一个关键词后即可停止继续匹配
                    }
                }
            }
        }

//        Map<Integer, String> questions1 = questionMapper.getAllQuestions1();
//        Map<String, Integer> errorFrequency1 = new HashMap<>(); // 统计错误出现的次数
//        for (Map.Entry<Integer, String> entry : questions1.entrySet()) {
//            int id = entry.getKey();
//            String question_contect = entry.getValue();
//            String answer_contect = questionMapper.getAnswersByQuestionId(id);
//            // 获取问题的标题和正文
//            String content = question_contect + " " + answer_contect;
//
//            // 匹配错误关键词
//            Matcher matcher = pattern.matcher(content);
//            while (matcher.find()) {
//                String matchedError = matcher.group(); // 匹配到的错误文本
//                for (String keyword : errorKeywords) {
//                    if (matchedError.equalsIgnoreCase(keyword)) { // 比较是否匹配关键词
//                        errorFrequency.put(keyword, errorFrequency.getOrDefault(keyword, 0) + 1);
//                        break; // 匹配到一个关键词后即可停止继续匹配
//                    }
//                }
//            }
//        }





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
