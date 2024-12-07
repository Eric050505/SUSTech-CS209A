package com.example.Service;

import com.example.DTO.AnswerDTO;
import com.example.DTO.ErrorDTO;
import com.example.DTO.SectionsDTO;
import com.example.Mapper.AnswerMapper;
import com.example.Model.Answer;
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
        int maxScore = x;
        int MAX = answerMapper.getMaxReputation();
        if (maxScore > MAX) {maxScore = MAX;}
        int[] segments = new int[n + 1];
        int step = maxScore / n;
        for (int i = 0; i <= n-1; i++) {
            segments[i] = i * step;
        }

        Map<String, Float> AverageScores = new HashMap<>();
        segments[n] = maxScore;
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


    public List<SectionsDTO> getSecAnsTime(int n, int x) {
        int maxTime = x;
        int MAX = answerMapper.getMaxTimeDiff();
        if (maxTime > MAX) {maxTime = MAX;}
        int[] segments = new int[n + 1];
        int step = maxTime / n;
        for (int i = 0; i <= n-1; i++) {
            segments[i] = i * step;
        }

        Map<String, Float> AverageScores = new HashMap<>();
        segments[n] = maxTime;
        for (int i = 0; i <= n-1; i++) {
            String section = segments[i] + "-" + segments[i+1];
            float average_score = answerMapper.getAverageScore_time(segments[i],segments[i+1])  ;
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

    public List<SectionsDTO> getSecAnsLength(int n, int x) {
        int maxlength = x;
        int MAX = answerMapper.getLongestAnswerLength();
        if (maxlength > MAX) {maxlength = MAX;}
        int[] segments = new int[n + 1];
        int step = maxlength / n;
        for (int i = 0; i <= n-1; i++) {
            segments[i] = i * step;
        }

        Map<String, Float> AverageScores = new HashMap<>();
        segments[n] = maxlength;
        for (int i = 0; i <= n-1; i++) {
            String section = segments[i] + "-" + segments[i+1];
            float average_score = answerMapper.getAverageScore_Length(segments[i],segments[i+1])  ;
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
