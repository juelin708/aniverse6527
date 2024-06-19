package com.example.aniverseapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.aniverseapp.converter.UserConverter;
import com.example.aniverseapp.dao.User;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.Response;
import com.example.aniverseapp.dao.UserRepository;

@Service
public class UserServiceAuth implements UserService {
    
    @Autowired
    private UserRepository userRepository;

    @Override
    public UserProfileDTO getUserById(Long id) {
        User user = userRepository.findById(id).orElse(null);
        return user != null ? UserConverter.convertToUserProfileDTO(user) : null;
    }

    @Override
    public Response registerUser(UserAuthDTO userDTO) {
        if (userRepository.findByUsername(userDTO.getUsername()) != null) {
            return Response.newFailure("Username already taken");
        }
        User user = UserConverter.convertToEntity(userDTO);
        user.setPassword(userDTO.getPassword());
        userRepository.save(user);
        return Response.newSuccess("User registered successfully");
    }

    public Response loginUser(UserAuthDTO userDTO) {
        User user = userRepository.findByUsername(userDTO.getUsername());
        if (user != null && userDTO.getPassword().equals(user.getPassword())) {
            return Response.newSuccess("Login successful");
        } else if (user == null) {
            return Response.newFailure("Invalid Username");
        } else {
            return Response.newFailure("Invalid password");
        }
    }
}
