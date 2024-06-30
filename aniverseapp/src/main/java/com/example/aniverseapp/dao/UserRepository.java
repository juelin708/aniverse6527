package com.example.aniverseapp.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);

    /*@Query("select u.followings from User u where u.id = :id")
    List<User> findFollowingsById(@Param("id") long id);

    @Query("select u.fans from User u where u.id = :id")
    List<User> findFansById(@Param("id") long id);*/
}