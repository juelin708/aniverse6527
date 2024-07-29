package com.example.aniverseapp.converter;

import com.example.aniverseapp.dao.User;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.dto.UserAuthDTO;

import java.util.ArrayList;
import java.util.List;

public class UserConverter {

    public static UserProfileDTO convertToUserProfileDTO(User user) {
        UserProfileDTO userDTO = new UserProfileDTO();
        userDTO.setUsername(user.getUsername());
        userDTO.setAvatarUrl(user.getAvatarUrl());
        userDTO.setBio(user.getBio());

        List<User> followings = user.getFollowings();
        List<String> followingsNames = new ArrayList<>();
        if (followings == null) {
            userDTO.setFollowings(followingsNames);
            userDTO.setFollowingNum(0);

        } else {
            for (User following : followings) {
                String followingName = following.getUsername();
                followingsNames.add(followingName);
            }
            userDTO.setFollowings(followingsNames);
            userDTO.setFollowingNum(followings.size());
        }
        
        userDTO.setFollowings(followingsNames);

        List<User> fans = user.getFans();
        List<String> fansNames = new ArrayList<>();
        if (fans == null) {
            userDTO.setFans(fansNames);
            userDTO.setFanNum(0);
        } else {
            for (User fan : fans) {
                String fanName = fan.getUsername();
                fansNames.add(fanName);
            }
            userDTO.setFans(fansNames);
            userDTO.setFanNum(fans.size());
        }
        
        userDTO.setId(user.getId());
        return userDTO;
    }

    public static User convertToEntity(UserAuthDTO userDTO) {
        User user = new User();
        user.setUsername(userDTO.getUsername());
        user.setPassword(userDTO.getPassword());
        return user;
    }
}
