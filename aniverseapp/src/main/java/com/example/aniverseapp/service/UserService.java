package com.example.aniverseapp.service;

import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserUpdateDTO;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.Response;

import java.util.List;

public interface UserService {
    Response<UserProfileDTO> getUserById(Long id);
    Response<UserProfileDTO> getUserByUsername(String username);
    Response<Void> registerUser(UserAuthDTO userDTO);
    Response<Void> loginUser(UserAuthDTO userDTO);
    Response<Void> deleteUserById(long id);
    Response<UserProfileDTO> updateUserById(long id, UserUpdateDTO userDTO);
    Response<List<UserProfileDTO>> findFollowings(long id);
    Response<List<UserProfileDTO>> findFans(long id);

}
