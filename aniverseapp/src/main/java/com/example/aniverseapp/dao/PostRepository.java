package com.example.aniverseapp.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long> {
    List<Post> findByUserId(Long userId);
    List<Post> findByAnimalId(Long animalId);
    
    @Query("SELECT p FROM Post p JOIN p.likedBy u WHERE u.id = :userId")
    List<Post> findPostsLikedByUserId(@Param("userId") Long userId);
}

