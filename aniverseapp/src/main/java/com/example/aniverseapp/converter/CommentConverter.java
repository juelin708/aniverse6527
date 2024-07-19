package com.example.aniverseapp.converter;

import com.example.aniverseapp.dao.*;
import com.example.aniverseapp.dto.CommentDTO;

public class CommentConverter {
    public static CommentDTO convertToDTO(Comment comment) {
        CommentDTO dto = new CommentDTO();
        dto.setId(comment.getId());
        dto.setUsername(comment.getUser().getUsername());
        dto.setPostId(comment.getId());
        dto.setContent(comment.getContent());
        dto.setDate(comment.getDate());
        return dto;
    }
}
