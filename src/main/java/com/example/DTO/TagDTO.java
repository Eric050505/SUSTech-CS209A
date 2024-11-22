package com.example.DTO;

public class TagDTO {
    private String topic;
    private int hot;

    public TagDTO(String topic, int hot) {
        this.topic = topic;
        this.hot = hot;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }

    @Override
    public String toString() {
        return "TagDTO{" +
                "topic='" + topic + '\'' +
                ", hot=" + hot +
                '}';
    }
}
