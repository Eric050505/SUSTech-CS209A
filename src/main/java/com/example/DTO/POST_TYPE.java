package com.example.DTO;

public enum POST_TYPE {
    QUESTION, ANSWER;

    public static POST_TYPE fromString(String postType) {
        for (POST_TYPE type : POST_TYPE.values()) {
            if (type.name().equals(postType.toUpperCase())) {
                return type;
            }
        }
        return null;
    }
}
