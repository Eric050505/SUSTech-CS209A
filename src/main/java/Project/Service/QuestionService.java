package Project.Service;

import Project.DTO.ErrorDTO;
import Project.DTO.TagDTO;
import Project.Mapper.QuestionMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
        List<String> errorKeywords = Arrays.asList("NullPointerException", "ArrayIndexOutOfBoundsException", "ClassNotFoundException", "IllegalArgumentException", "OutOfMemoryError", "StackOverflowError", "IOException", "FileNotFoundException", "ArithmeticException", "NumberFormatException", "InterruptedException", "IllegalStateException", "NoSuchElementException", "UnsupportedOperationException", "ConcurrentModificationException", "SecurityException", "AssertionError", "ClassCastException", "SQLException", "MalformedURLException", "IndexOutOfBoundsException", "IllegalAccessException", "InstantiationException", "NoClassDefFoundError", "UnsatisfiedLinkError", "IllegalMonitorStateException", "EOFException", "BindException", "SocketTimeoutException", "UnknownHostException", "AbstractMethodError", "AssertionError", "BootstrapMethodError", "ClassCircularityError", "ClassFormatError", "ExceptionInInitializerError", "IncompatibleClassChangeError", "InternalError", "LinkageError", "NoSuchFieldError", "NoSuchMethodError", "OutOfMemoryError", "StackOverflowError", "ThreadDeath", "UnknownError", "UnsatisfiedLinkError", "VerifyError", "VirtualMachineError", "ServiceConfigurationError", "LinkageError", "OutOfMemoryError", "ThreadDeath", "StackOverflowError", "ZipError", "UnknownError");

        List<Map<String, Object>> results = questionMapper.getAllQuestions();
        Map<String, Integer> errorFrequency = new HashMap<>();
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
                        break;
                    }
                }
            }
        }

        List<Map.Entry<String, Integer>> sortedErrors = new ArrayList<>(errorFrequency.entrySet());
        sortedErrors.sort((a, b) -> b.getValue().compareTo(a.getValue()));

        List<ErrorDTO> topErrors = new ArrayList<>();
        for (int i = 0; i < Math.min(n, sortedErrors.size()); i++) {
            Map.Entry<String, Integer> entry = sortedErrors.get(i);
            topErrors.add(new ErrorDTO(entry.getKey(), entry.getValue()));
        }
        return topErrors;
    }

    public TagDTO getTagFrequency(String tag) {
        return questionMapper.getTopicFrequency(tag);
    }

    public ErrorDTO getErrorFrequency(String error) {
        List<Map<String, Object>> results = questionMapper.getAllQuestions();
        int frequency = 0;
        Pattern pattern = Pattern.compile(String.join("|", error), Pattern.CASE_INSENSITIVE);

        for (Map<String, Object> row : results) {
            Integer questionId = (Integer) row.get("question_id");
            String title = (String) row.get("title");
            String body = (String) row.get("body");
            String answers = questionMapper.getAnswersByQuestionId(questionId);
            String content = title + " " + body + " " + answers;
            Matcher matcher = pattern.matcher(content);
            while (matcher.find()) {
                String matchedError = matcher.group();
                if (matchedError.equalsIgnoreCase(error)) {
                    frequency++;
                    break;
                }
            }
        }
        return new ErrorDTO(error, frequency);
    }
}
