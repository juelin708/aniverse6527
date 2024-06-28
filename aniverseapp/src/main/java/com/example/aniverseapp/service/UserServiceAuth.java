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
    public Response<UserProfileDTO> getUserById(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            Response<UserProfileDTO> response = new Response<UserProfileDTO>();
            response.setData(UserConverter.convertToUserProfileDTO(user));
            response.setSuccess(true);
            return response;
        } else {
            return null;
        }
    }

    @Override
    public Response<Void> registerUser(UserAuthDTO userDTO) {
        if (userRepository.findByUsername(userDTO.getUsername()) != null) {
            return Response.newFailure("Username already taken");
        }
        User user = UserConverter.convertToEntity(userDTO);
        user.setPassword(userDTO.getPassword());
        userRepository.save(user);
        return Response.<Void>newSuccess(null, "User registered successfully");
    }

    public Response<Void> loginUser(UserAuthDTO userDTO) {
        User user = userRepository.findByUsername(userDTO.getUsername());
        if (user != null && userDTO.getPassword().equals(user.getPassword())) {
            return Response.newSuccess(null, "Login successful");
        } else if (user == null) {
            return Response.newFailure("Invalid username");
        } else {
            return Response.newFailure("Invalid password");
        }
    }
}
