package com.example.aniverseapp.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);

    @Query("select u.followings from User u where u.id = :id")
    List<User> findFollowingsById(@Param("id") long id);

    @Query("select u.fans from User u where u.id = :id")
    List<User> findFansById(@Param("id") long id);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO fans (fan_id, followed_id) VALUES (:fanId, :followedId)", nativeQuery = true)
    void followAUser(@Param("fanId") Long fanId, @Param("followedId") Long followedId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM fans WHERE fan_id = :fanId AND followed_id = :followedId", nativeQuery = true)
    void cancelFollowAUser(@Param("fanId") Long fanId, @Param("followedId") Long followedId);

    @Query("SELECT COUNT(p) FROM Post p WHERE p.user.id = :userId")
    Integer countPosts(Long userId);

    @Query("SELECT COUNT(p) FROM Post p JOIN p.likedBy u WHERE u.id = :userId")
    Integer countLikedPosts(@Param("userId") Long userId);

    @Query(value="SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM fans WHERE fan_id = :fanId AND followed_id = :followedId", nativeQuery = true)
    Integer isFollowing(@Param("fanId") Long fanId, @Param("followedId") Long followedId);
}
