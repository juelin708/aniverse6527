package com.example.aniverseapp.dto;

public class UserUpdateDTO {
    private String password;
    //private String avatarUrl;
    private String bio;

    public String getPassword() {
        return password;
    }

    public void setPassword(String pwd) {
        this.password = pwd;
    }
/* 
    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
*/
    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

}
