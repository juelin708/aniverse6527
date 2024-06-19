package com.example.aniverseapp.controller;

import com.example.aniverseapp.Response;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("user/{id}")
    public UserProfileDTO getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
    }
    
    @PostMapping("/register")
    public Response registerUser(@RequestBody UserAuthDTO userDTO) {
        return userService.registerUser(userDTO);
    }

    @PostMapping("/login")
    public Response loginUser(@RequestBody UserAuthDTO userDTO) {
        return userService.loginUser(userDTO);
    }
}
