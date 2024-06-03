package com.example.aniverseapp;

import com.example.aniverseapp.User;
import com.example.aniverseapp.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody User user) {
        User registered = userService.registerUser(user);
        return ResponseEntity.ok(registered);
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestParam String username, @RequestParam String password) {
        User authenticated = userService.authenticateUser(username, password);
        if (authenticated != null) {
            return ResponseEntity.ok(authenticated);
        }
        return ResponseEntity.status(401).build();
    }
}
