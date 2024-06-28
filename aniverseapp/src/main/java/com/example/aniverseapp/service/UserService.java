package com.example.aniverseapp.service;

import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.Response;


public interface UserService {
    public Response<UserProfileDTO> getUserById(Long id);
    public Response<Void> registerUser(UserAuthDTO userDTO);
    public Response<Void> loginUser(UserAuthDTO userDTO);
}
