package com.example.aniverseapp.controller;

import com.example.aniverseapp.Response;
import com.example.aniverseapp.service.PostService;
import com.example.aniverseapp.dto.PostCreateDTO;
import com.example.aniverseapp.dto.PostDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/post")
public class PostController {

    @Autowired
    private PostService postService;

    @PostMapping("/create")
    public Response<PostDTO> createPost(@RequestBody PostCreateDTO dto) {
        return postService.createPost(dto);
    }

    @PostMapping("/like")
    public Response<Void> likePost(@RequestParam Long postId, @RequestParam Long userId) {
        return postService.likePost(postId, userId);
    }

    @DeleteMapping("/unlike")
    public Response<Void> unlikePost(@RequestParam Long postId, @RequestParam Long userId) {
        return postService.unlikePost(postId, userId);
    }

    @PostMapping("/comment")
    public Response<Void> commentPost(@RequestParam Long postId, @RequestParam Long userId, @RequestParam String content) {
        return postService.commentPost(postId, userId, content);
    }

    @GetMapping("/{id}")
    public Response<PostDTO> getPostById(@PathVariable Long id) {
        return postService.getPostById(id);
    }

    @GetMapping("/user/{userId}")
    public Response<List<PostDTO>> getPostsByUserId(@PathVariable Long userId) {
        return postService.getPostsByUserId(userId);
    }

    @GetMapping("/animal/{animalId}")
    public Response<List<PostDTO>> getPostsByAnimalId(@PathVariable Long animalId) {
        return postService.getPostsByAnimalId(animalId);
    }

    @DeleteMapping("/delete/{id}")
    public Response<Void> deletePostById(@PathVariable long id) {
        return postService.deletePostById(id);
    }

    @GetMapping("/likedBy/{userId}")
    public Response<List<PostDTO>> getPostsLikedByUser(@PathVariable Long userId) {
        return postService.getPostsLikedByUser(userId);
    }

    @GetMapping("{userId}/isLiking/{postId}")
    public Response<Integer> isLiking(@PathVariable Long userId, @PathVariable Long postId) {
        return postService.isLiking(userId, postId);
    }

    @GetMapping("all")
    public Response<List<PostDTO>> getAllPosts() {
        return postService.getAllPosts();
    }
}
