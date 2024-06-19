package com.example.aniverseapp.service;

import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.Response;


public interface UserService {
    public UserProfileDTO getUserById(Long id);
    public Response registerUser(UserAuthDTO userDTO);
    public Response loginUser(UserAuthDTO userDTO);
}
