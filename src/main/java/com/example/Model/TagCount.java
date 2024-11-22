package com.example.Model;

public class TagCount {
    private String topic;
    private int hot;

    public TagCount(String topic, int hot) {
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
}
