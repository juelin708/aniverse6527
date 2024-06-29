package com.example.aniverseapp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.aniverseapp.converter.UserConverter;
import com.example.aniverseapp.dao.User;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserUpdateDTO;
import com.example.aniverseapp.Response;
import com.example.aniverseapp.dao.UserRepository;

@Service
public class UserServiceImpl implements UserService {
    
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
            return Response.newFailure("User with id: " + id + " does not exist");
        }
    }
    @Override
    public Response<UserProfileDTO> getUserByUsername(String username) {
        User user = userRepository.findByUsername(username);
        if (user != null) {
            Response<UserProfileDTO> response = new Response<UserProfileDTO>();
            response.setData(UserConverter.convertToUserProfileDTO(user));
            response.setSuccess(true);
            return response;
        } else {
            return Response.newFailure("User with name: " + username + " does not exist");
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

    @Override
    public Response<Void> deleteUserById(long id) {
        if (userRepository.findById(id).isEmpty()) {
            return Response.newFailure("User with id: " + id + " does not exist");
        }
        userRepository.deleteById(id);
        return Response.newSuccess(null, "User with id: " + id + " deleted");
    }

    @Override
    public Response<UserProfileDTO> updateUserById(long id, UserUpdateDTO userDTO) {
        if (userRepository.findById(id).isEmpty()) {
            return Response.newFailure("User with id: " + id + " does not exist");
        }
        User original = userRepository.findById(id).orElse(null);
        original.setAvatarUrl(userDTO.getAvatarUrl());
        original.setBio(userDTO.getBio());
        userRepository.save(original);
        return Response.newSuccess(UserConverter.convertToUserProfileDTO(original), "User updated");
    }

    @Override
    public Response<List<UserProfileDTO>> findFollowings(long id) {
        if (userRepository.findById(id).isEmpty()) {
            return Response.newFailure("User with id: " + id + " does not exist");
        }
        List<User> followings = userRepository.findFollowingsById(id);
        List<UserProfileDTO> list = List.<UserProfileDTO>of();
        for (User user : followings) {
            list.add(UserConverter.convertToUserProfileDTO(user));
        }
        return Response.newSuccess(list, null);
    }

    @Override
    public Response<List<UserProfileDTO>> findFans(long id) {
        if (userRepository.findById(id).isEmpty()) {
            return Response.newFailure("User with id: " + id + " does not exist");
        }
        List<User> fans = userRepository.findFansById(id);
        List<UserProfileDTO> list = List.<UserProfileDTO>of();
        for (User user : fans) {
            list.add(UserConverter.convertToUserProfileDTO(user));
        }
        return Response.newSuccess(list, null);
    }
}

