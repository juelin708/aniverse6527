package com.example.aniverseapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.aniverseapp.dao.Tag;
import com.example.aniverseapp.dto.TagDTO;
import com.example.aniverseapp.dto.UserProfileDTO;
import com.example.aniverseapp.Response;
import com.example.aniverseapp.converter.TagConverter;
import com.example.aniverseapp.converter.UserConverter;
import com.example.aniverseapp.dao.TagRepository;
import com.example.aniverseapp.dao.User;

@Service
public class TagService {

    @Autowired
    private TagRepository tagRepository;

    public Response<TagDTO> getTagById(Long id) {
        Tag tag = tagRepository.findById(id).orElse(null);
        if (tag != null) {
            Response<TagDTO> response = new Response<TagDTO>();
            response.setData(TagConverter.convertToTagDTO(tag));
            response.setSuccess(true);
            return response;
        } else {
            return Response.newFailure("Tag with id: " + id + " does not exist");
        }
    }

    public Response<TagDTO> getTagByTagname(String tagname) {
        Tag tag = tagRepository.findByTagname(tagname);
        if (tag != null) {
            return Response.newSuccess(TagConverter.convertToTagDTO(tag), null);
        } else {
            return Response.newFailure("Tag with name: " + tagname + " does not exist");
        }
    }

    public Response<Void> addTag(TagDTO tagDTO) {
        if (tagRepository.findByTagname(tagDTO.getTagname()) != null) {
            return Response.newFailure("Tag already exists");
        }
        Tag tag = TagConverter.convertToEntity(tagDTO);
        tagRepository.save(tag);
        return Response.<Void>newSuccess(null, null);
    }

    public Response<Void> deleteTagById(long id) {
        if (tagRepository.findById(id).isEmpty()) {
            return Response.newFailure("Tag with id: " + id + " does not exist");
        }
        tagRepository.deleteById(id);
        return Response.newSuccess(null, "Tag with id: " + id + " deleted");
    }

    public Response<TagDTO> updateTagById(long id, String newTagname) {
        if (tagRepository.findById(id).isEmpty()) {
            return Response.newFailure("Tag with id: " + id + " does not exist");
        }
        Tag original = tagRepository.findById(id).orElse(null);
        original.setTagname(newTagname);
        tagRepository.save(original);
        return Response.newSuccess(TagConverter.convertToTagDTO(original), "Tag updated");
    }
}