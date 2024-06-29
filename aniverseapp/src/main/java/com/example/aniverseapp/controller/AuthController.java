package com.example.aniverseapp.controller;

import com.example.aniverseapp.Response;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserUpdateDTO;
import com.example.aniverseapp.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("user/{id}")
    public Response<UserProfileDTO> getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
    }

    @GetMapping("user/{username}")
    public Response<UserProfileDTO> getUserByUsername(@PathVariable String username) {
        return userService.getUserByUsername(username);
    }
    
    @PostMapping("/register")
    public Response<Void> registerUser(@RequestBody UserAuthDTO userDTO) {
        return userService.registerUser(userDTO);
    }

    @PostMapping("/login")
    public Response<Void> loginUser(@RequestBody UserAuthDTO userDTO) {
        return userService.loginUser(userDTO);
    }

    @DeleteMapping("/user/{id}")
    public Response<Void> deleteUserById(@PathVariable long id) {
        return userService.deleteUserById(id);
    }

    @PutMapping("user/{id}")
    public Response<UserProfileDTO> updateUserById(@PathVariable long id, @RequestBody UserUpdateDTO userDTO) {
        return userService.updateUserById(id, userDTO);
    }

    @GetMapping("followings/{id}")
    public Response<List<UserProfileDTO>> findFollowings(@PathVariable long id) {
        return userService.findFollowings(id);
    } 

    @GetMapping("fans/{id}")
    public Response<List<UserProfileDTO>> findFans(@PathVariable long id) {
        return userService.findFans(id);
    } 
}
