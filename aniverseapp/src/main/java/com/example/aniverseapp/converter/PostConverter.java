package com.example.aniverseapp.converter;

import com.example.aniverseapp.dao.*;
import com.example.aniverseapp.dto.CommentDTO;
import com.example.aniverseapp.dto.PostDTO;

import java.util.List;
import java.util.ArrayList;

public class PostConverter {
    public static PostDTO convertToPostDTO(Post post) {
        PostDTO dto = new PostDTO();
        dto.setId(post.getId());
        dto.setUsername(post.getUser().getUsername());
        dto.setAnimalname(post.getAnimal().getAnimalname());
        dto.setContent(post.getContent());
        dto.setDate(post.getDate());
        dto.setTitle(post.getTitle());
        dto.setImageUrl(post.getImageUrl());

        List<String> likedByNames = new ArrayList<>();
        List<User> likedBy = post.getLikedBy();
        if (likedBy == null) {
            dto.setLikedBy(likedByNames);
        } else {
            for (User user : likedBy) {
                likedByNames.add(user.getUsername());
            }
            dto.setLikedBy(likedByNames);
        }
           
        List<CommentDTO> commentDTOs = new ArrayList<>();
        List<Comment> comments = post.getComments();
        if (comments == null) {
            dto.setComments(commentDTOs);
        } else {
            for (Comment comment : comments) {
                commentDTOs.add(CommentConverter.convertToDTO(comment));
            }
            dto.setComments(commentDTOs);
        }

        if (likedBy == null) {
            dto.setLikeNum(0);
        } else {
            dto.setLikeNum(likedBy.size());
        }

        if (post.getComments() == null) {
            dto.setCommentNum(0);
        } else {
            dto.setCommentNum(comments.size());
        }
        
        return dto;
    }
}
