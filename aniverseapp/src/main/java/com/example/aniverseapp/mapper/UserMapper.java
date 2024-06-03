package com.example.aniverseapp.mapper;

import com.example.aniverseapp.User;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper {
    User findByUsername(String username);
    void insertUser(User user);
}
