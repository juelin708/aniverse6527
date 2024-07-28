package com.example.aniverseapp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
            UserProfileDTO userDTO = UserConverter.convertToUserProfileDTO(user);
            userDTO.setPostNum(userRepository.countPosts(id));
            userDTO.setLikedPostNum(userRepository.countLikedPosts(id));
            response.setData(userDTO);
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
            UserProfileDTO userDTO = UserConverter.convertToUserProfileDTO(user);
            userDTO.setPostNum(userRepository.countPosts(user.getId()));
            userDTO.setLikedPostNum(userRepository.countLikedPosts(user.getId()));
            response.setData(userDTO);
            response.setSuccess(true);
            return response;
        } else {
            return Response.newFailure("User with name: " + username + " does not exist");
        }
    }

    @Override
    public Response<UserProfileDTO> registerUser(UserAuthDTO userDTO) {
        if (userDTO.getUsername() == null) {
            return Response.newFailure("Username cannot be null");
        }
        if (userDTO.getPassword() == null) {
            return Response.newFailure("Password cannot be null");
        }
        if (userRepository.findByUsername(userDTO.getUsername()) != null) {
            return Response.newFailure("Username already taken");
        }

        User user = UserConverter.convertToEntity(userDTO);
        userRepository.save(user);
        UserProfileDTO dto = UserConverter.convertToUserProfileDTO(user);
        dto.setPostNum(userRepository.countPosts(user.getId()));
        dto.setLikedPostNum(userRepository.countLikedPosts(user.getId()));
        return Response.newSuccess(dto, "User registered successfully");
    }

    public Response<UserProfileDTO> loginUser(UserAuthDTO userDTO) {
        User user = userRepository.findByUsername(userDTO.getUsername());
        if (user != null && userDTO.getPassword().equals(user.getPassword())) {
            UserProfileDTO dto = UserConverter.convertToUserProfileDTO(user);
            dto.setPostNum(userRepository.countPosts(user.getId()));
            dto.setLikedPostNum(userRepository.countLikedPosts(user.getId()));
            return Response.newSuccess(dto, "Login successful");
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
        if (userDTO.getAvatarUrl() != null && userDTO.getAvatarUrl().length() != 0) {
            original.setAvatarUrl(userDTO.getAvatarUrl());
        }
        if (userDTO.getBio() != null && userDTO.getBio().length() != 0) {
            original.setBio(userDTO.getBio());
        }
        if (userDTO.getPassword() != null && userDTO.getPassword().length() != 0) {
            original.setPassword(userDTO.getPassword());
        }
        userRepository.save(original);
        UserProfileDTO dto = UserConverter.convertToUserProfileDTO(original);
        dto.setPostNum(userRepository.countPosts(id));
        dto.setLikedPostNum(userRepository.countLikedPosts(id));
        return Response.newSuccess(dto, "User updated");
    }

    @Override
    public Response<List<String>> findFollowings(long id) {
        if (userRepository.findById(id).isEmpty()) {
            return Response.newFailure("User with id: " + id + " does not exist");
        }
        User user = userRepository.findById(id).get();
        List<String> list = UserConverter.convertToUserProfileDTO(user).getFollowings();
        return Response.newSuccess(list, null);
    }

    @Override
    public Response<List<String>> findFans(long id) {
        if (userRepository.findById(id).isEmpty()) {
            return Response.newFailure("User with id: " + id + " does not exist");
        }
        User user = userRepository.findById(id).get();
        List<String> list = UserConverter.convertToUserProfileDTO(user).getFans();
        return Response.newSuccess(list, null);
    }

    @Override
    @Transactional
    public Response<Void> followAUser(Long fanId, Long followedId) {
        if (fanId.equals(followedId)) {
            return Response.newFailure("You cannot follow yourself");
        }
        userRepository.followAUser(fanId, followedId);
        return Response.newSuccess(null, null);
    }

    @Override
    @Transactional
    public Response<Void> cancelFollowAUser(Long fanId, Long followedId) {
        userRepository.cancelFollowAUser(fanId, followedId);
        return Response.newSuccess(null, null);
    }

    @Override
    public Response<Integer> isFollowing(Long fanId, Long followedId) {
        if (userRepository.findById(fanId).isEmpty()) {
            return Response.newFailure("User with id: " + fanId + " does not exist");
        }
        if (userRepository.findById(followedId).isEmpty()) {
            return Response.newFailure("User with id: " + followedId + " does not exist");
        }
        return Response.newSuccess(userRepository.isFollowing(fanId, followedId), null);
    }
}

