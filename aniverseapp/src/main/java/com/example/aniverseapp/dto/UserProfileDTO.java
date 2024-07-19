package com.example.aniverseapp.dto;

import java.util.List;

public class UserProfileDTO {
    private Long id;
    private String username;
    private String avatarUrl;
    private String bio;
    private List<String> followings;
    private List<String> fans;
    private Integer postNum;    
    private Integer fanNum;     
    private Integer followingNum;  
    private boolean isFollowing; 

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public List<String> getFollowings() {
        return followings;
    }

    public List<String> getFans() {
        return fans;
    }

    public void setFollowings(List<String> list) {
        this.followings = list;
    }

    public void setFans(List<String> list) {
        this.fans = list;
    }

    public Integer getPostNum() {
        return postNum;
    }

    public void setPostNum(Integer postNum) {
        this.postNum = postNum;
    }

    public Integer getFanNum() {
        return fanNum;
    }

    public void setFanNum(Integer fanNum) {
        this.fanNum = fanNum;
    }

    public Integer getFollowingNum() {
        return followingNum;
    }

    public void setFollowingNum(Integer followingNum) {
        this.followingNum = followingNum;
    }

    public boolean getIsFollowing() {
        return isFollowing;
    }

    public void setIsFollowing(boolean isFollowing) {
        this.isFollowing = isFollowing;
    }
}
