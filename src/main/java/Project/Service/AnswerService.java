package Project.Service;


import Project.DTO.AnswerDTO;
import Project.DTO.SectionsDTO;
import Project.Mapper.AnswerMapper;
import Project.Model.Answer;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class AnswerService {

    private final AnswerMapper answerMapper;

    public AnswerDTO getAnswerById(int id) {
        Answer answer = answerMapper.getAnswerById(id);
        return new AnswerDTO(answer);
    }

    public List<SectionsDTO> getSecUserPoints(int n, int x) {
        int[] segments = new int[n + 1];
        int step = x / n;
        for (int i = 0; i <= n-1; i++) {
            segments[i] = i * step;
        }

        Map<String, Float> AverageScores = new HashMap<>();
        segments[n] = x;
        for (int i = 0; i <= n-1; i++) {
            String section = segments[i] + "-" + segments[i+1];
            float average_score = answerMapper.getAverageScore(segments[i],segments[i+1])  ;
            AverageScores.put(section,average_score);
        }

        List<Map.Entry<String, Float>> AverageScoresEntry = new ArrayList<>(AverageScores.entrySet());
        AverageScoresEntry.sort((a, b) -> {
            int aLowerBound = Integer.parseInt(a.getKey().split("-")[0]);
            int bLowerBound = Integer.parseInt(b.getKey().split("-")[0]);
            return Integer.compare(aLowerBound, bLowerBound);
        });
        List<SectionsDTO> Sections = new ArrayList<>();
        for (int i = 0; i < Math.min(n, AverageScoresEntry.size()); i++) {
            Map.Entry<String, Float> entry = AverageScoresEntry.get(i);
            Sections.add(new SectionsDTO(entry.getKey(), entry.getValue()));
        }
        return Sections;

    }
}
