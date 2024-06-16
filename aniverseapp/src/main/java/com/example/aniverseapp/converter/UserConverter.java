package com.example.aniverseapp.converter;

import com.example.aniverseapp.dto.UserAuthDTO;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dao.User;

public class UserConverter {

    public static UserAuthDTO convertToUserAuthDTO(User user) {
        UserAuthDTO userDTO = new UserAuthDTO();
        userDTO.setUsername(user.getUsername());
        userDTO.setPassword(user.getPassword());
        return userDTO;
    }

    public static UserProfileDTO convertToUserProfileDTO(User user) {
        UserProfileDTO userDTO = new UserProfileDTO();
        userDTO.setUsername(user.getUsername());
        return userDTO;
    }

    public static User convertToEntity(UserAuthDTO userDTO) {
        User user = new User();
        user.setUsername(userDTO.getUsername());
        user.setPassword(userDTO.getPassword());
        return user;
    }
}
