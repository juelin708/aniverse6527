package com.example.aniverseapp;

public class ChatPreview {
    private String username;
    private String lastMessage;

    public ChatPreview(String username, String lastMessage) {
        this.username = username;
        this.lastMessage = lastMessage;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(String lastMessage) {
        this.lastMessage = lastMessage;
    }
}
