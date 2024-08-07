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

import java.util.ArrayList;
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

    @Column(name="avatar_url")
    private String avatarUrl;

    @Column(name="bio")
    private String bio;
 
    @ManyToMany
    @JoinTable(
        name = "fans",
        joinColumns = @JoinColumn(name = "fan_id"),
        inverseJoinColumns =@JoinColumn(name = "followed_id")
    )
    private List<User> followings = new ArrayList<>();
    
    @ManyToMany
    @JoinTable(
        name = "fans",
        joinColumns = @JoinColumn(name = "followed_id"),
        inverseJoinColumns =@JoinColumn(name = "fan_id")
    )
    private List<User> fans;


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
}
