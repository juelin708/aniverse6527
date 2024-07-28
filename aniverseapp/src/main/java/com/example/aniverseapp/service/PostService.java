package com.example.aniverseapp.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.aniverseapp.dao.*;
import com.example.aniverseapp.dto.PostCreateDTO;
import com.example.aniverseapp.dto.PostDTO;
import com.example.aniverseapp.Response;
import com.example.aniverseapp.converter.PostConverter;

@Service
public class PostService {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AnimalRepository animalRepository;

    public Response<PostDTO> createPost(PostCreateDTO dto) {
        Long userId = dto.getUserId();
        if (userRepository.findById(userId).isEmpty()) {
            return Response.newFailure("User with id: " + userId + " does not exist");
        }
        Long animalId = dto.getAnimalId();
        if (animalRepository.findById(animalId).isEmpty()) {
            return Response.newFailure("Animal with id: " + animalId + " does not exist");
        }
        if (dto.getContent() == null) {
            return Response.newFailure("Post content cannot be null");
        }

        Post post = new Post();
        post.setUser(userRepository.findById(userId).get());
        post.setAnimal(animalRepository.findById(animalId).get());
        post.setContent(dto.getContent());
        post.setDate(java.time.LocalDate.now());
        if (dto.getTitle() != null) {
            post.setTitle(dto.getTitle());
        }
        if (dto.getImageUrl() != null) {
            post.setImageUrl(dto.getImageUrl());
        }
        postRepository.save(post);
        return Response.newSuccess(PostConverter.convertToPostDTO(post), "Post created successfully");
    }

    @Transactional
    public Response<Void> likePost(Long postId, Long userId) {
        if (postRepository.findById(postId).isEmpty()) {
            return Response.newFailure("Post with id: " + postId + " does not exist");
        }
        if (userRepository.findById(userId).isEmpty()) {
            return Response.newFailure("User with id: " + userId + " does not exist");
        }
        postRepository.likePost(postId, userId);
        return Response.newSuccess(null, "Post liked successfully");
    }

    @Transactional
    public Response<Void> unlikePost(Long postId, Long userId) {
        postRepository.unlikePost(postId, userId);
        return Response.newSuccess(null, "Post unliked successfully");
    }

    public Response<Void> commentPost(Long postId, Long userId, String content) {
        if (postRepository.findById(postId).isEmpty()) {
            return Response.newFailure("Post with id: " + postId + " does not exist");
        }
        if (userRepository.findById(userId).isEmpty()) {
            return Response.newFailure("User with id: " + userId + " does not exist");
        }
        Post post = postRepository.findById(postId).get();
        User user = userRepository.findById(userId).get();
        Comment comment = new Comment();
        comment.setPost(post);
        comment.setUser(user);
        comment.setContent(content);
        comment.setDate(java.time.LocalDate.now());
        post.getComments().add(comment);
        postRepository.save(post);
        return Response.newSuccess(null, "Comment added successfully");
    }

    public Response<PostDTO> getPostById(Long id) {
        if (postRepository.findById(id).isEmpty()) {
            return Response.newFailure("Post with id: " + id + " does not exist");
        }
        Post post = postRepository.findById(id).get();
        return Response.newSuccess(PostConverter.convertToPostDTO(post), null) ;
    }

    public Response<List<PostDTO>> getPostsByUserId(Long userId) {
        if (userRepository.findById(userId).isEmpty()) {
            return Response.newFailure("User with id: " + userId + " does not exist");
        }
        List<PostDTO> posts = new ArrayList<>();
        for (Post post : postRepository.findByUserId(userId)) {
            posts.add(PostConverter.convertToPostDTO(post));
        }
        return Response.newSuccess(posts, null);
    }

    public Response<List<PostDTO>> getPostsByAnimalId(Long animalId) {
        if (animalRepository.findById(animalId).isEmpty()) {
            return Response.newFailure("Animal with id: " + animalId + " does not exist");
        }
        List<PostDTO> posts = new ArrayList<>();
        for (Post post : postRepository.findByAnimalId(animalId)) {
            posts.add(PostConverter.convertToPostDTO(post));
        }
        return Response.newSuccess(posts, null);
    }

    public Response<Void> deletePostById(long id) {
        if (postRepository.findById(id).isEmpty()) {
            return Response.newFailure("Post with id: " + id + " does not exist");
        }
        postRepository.deleteById(id);
        return Response.newSuccess(null, "Post with id: " + id + " deleted");
    }

    public Response<List<PostDTO>> getPostsLikedByUser(Long userId) {
        if (userRepository.findById(userId).isEmpty()) {
            return Response.newFailure("User with id: " + userId + " does not exist");
        }
        List<Post> posts = postRepository.findPostsLikedByUserId(userId);
        List<PostDTO> postDTOs = new ArrayList<>();
        for (Post post : posts) {
            postDTOs.add(PostConverter.convertToPostDTO(post));
        }
        return Response.newSuccess(postDTOs, null);
    }

    public Response<Integer> isLiking(Long userId, Long postId) {
        if (userRepository.findById(userId).isEmpty()) {
            return Response.newFailure("User with id: " + userId + " does not exist");
        }
        if (postRepository.findById(postId).isEmpty()) {
            return Response.newFailure("Post with id: " + postId + " does not exist");
        }
        return Response.newSuccess(postRepository.isLiking(userId, postId), null);
    }

    public Response<List<PostDTO>> getAllPosts() {
        List<Post> posts = postRepository.findAll();
        List<PostDTO> postDTOs = new ArrayList<>();
        if (posts == null) {
            return Response.newFailure("No posts found");
        }
        for (Post post : posts) {
            postDTOs.add(PostConverter.convertToPostDTO(post));
        }
        return Response.newSuccess(postDTOs, null);
    }
}

