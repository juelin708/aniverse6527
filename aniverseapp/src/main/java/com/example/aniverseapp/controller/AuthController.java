package com.example.aniverseapp.controller;

import com.example.aniverseapp.Response;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserUpdateDTO;
import com.example.aniverseapp.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("user/{id}")
    public Response<UserProfileDTO> getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
    }

    @GetMapping("user/byUsername/{username}")
    public Response<UserProfileDTO> getUserByUsername(@PathVariable String username) {
        return userService.getUserByUsername(username);
    }
    
    @PostMapping("/register")
    public Response<UserProfileDTO> registerUser(@RequestBody UserAuthDTO userDTO) {
        return userService.registerUser(userDTO);
    }

    @PostMapping("/login")
    public Response<UserProfileDTO> loginUser(@RequestBody UserAuthDTO userDTO) {
        return userService.loginUser(userDTO);
    }

    @DeleteMapping("user/delete/{id}")
    public Response<Void> deleteUserById(@PathVariable long id) {
        return userService.deleteUserById(id);
    }

    @PutMapping("user/update/{id}")
    public Response<UserProfileDTO> updateUserById(@PathVariable long id, @RequestBody UserUpdateDTO userDTO) {
        return userService.updateUserById(id, userDTO);
    }

    @GetMapping("followings/{id}")
    public Response<List<String>> findFollowings(@PathVariable long id) {
        return userService.findFollowings(id);
    } 

    @GetMapping("fans/{id}")
    public Response<List<String>> findFans(@PathVariable long id) {
        return userService.findFans(id);
    } 

    @PostMapping("{fanId}/follow/{followedId}")
    public Response<Void> followAUser(@PathVariable Long fanId, @PathVariable Long followedId) {
        return userService.followAUser(fanId, followedId);
    }

    @DeleteMapping("/{fanId}/unfollow/{followedId}")
    public Response<Void> cancelFollowAUser(@PathVariable Long fanId, @PathVariable Long followedId) {
        return userService.cancelFollowAUser(fanId, followedId);
    }

    @GetMapping("{fanId}/isFollowing/{followedId}")
    public Response<Integer> isFollowing(@PathVariable Long fanId, @PathVariable Long followedId) {
        return userService.isFollowing(fanId, followedId);
    }
    
}
