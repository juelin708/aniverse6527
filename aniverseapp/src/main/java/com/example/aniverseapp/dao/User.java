package com.example.aniverseapp.dao;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Table;
import jakarta.persistence.JoinTable;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Column;
import static jakarta.persistence.GenerationType.IDENTITY;

import java.util.List;

@Entity
@Table(name="users")
public class User {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = IDENTITY)
    private long id;

    @Column(name="username")
    private String username;

    @Column(name="password")
    private String password;

   // @Column(name="avatarUrl")
   // private String avatarUrl;

    @Column(name="bio")
    private String bio;
/* 
    @ManyToMany
    @JoinTable(
        name = "fans",
        joinColumns = @JoinColumn(name = "fanId"),
        inverseJoinColumns =@JoinColumn(name = "followedId")
    )
    private List<User> followings;

    @ManyToMany
    @JoinTable(
        name = "fans",
        joinColumns = @JoinColumn(name = "followedId"),
        inverseJoinColumns =@JoinColumn(name = "fanId")
    )
    private List<User> fans;

    private Integer postNum;    
    private Integer fanNum;     
    private Integer followingNum;  
    private boolean isFollowing;   
*/
    
    // Getters and setters
    public long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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
/* 
    public List<User> getFollowings() {
        return followings;
    }

    public List<User> getFans() {
        return fans;
    }

    public void setFollowings(List<User> list) {
        this.followings = list;
    }

    public void setFans(List<User> list) {
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
*/
}
