package com.example.aniverseapp.service;

import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserUpdateDTO;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.Response;

import java.util.List;

public interface UserService {
    Response<UserProfileDTO> getUserById(Long id);
    Response<UserProfileDTO> getUserByUsername(String username);
    Response<UserProfileDTO> registerUser(UserAuthDTO userDTO);
    Response<UserProfileDTO> loginUser(UserAuthDTO userDTO);
    Response<Void> deleteUserById(long id);
    Response<UserProfileDTO> updateUserById(long id, UserUpdateDTO userDTO);
    Response<List<String>> findFollowings(long id);
    Response<List<String>> findFans(long id);
    Response<Void> followAUser(Long fanId, Long followedId);
    Response<Void> cancelFollowAUser(Long fanId, Long followedId);
    Response<Integer> isFollowing(Long fanId, Long followedId);
}
