package com.example.aniverseapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.aniverseapp.dao.Tag;
import com.example.aniverseapp.Response;
import com.example.aniverseapp.dao.TagRepository;

@Service
public class TagService {

    @Autowired
    private TagRepository tagRepository;

    public Response<Void> addTag(Tag tag) {
        if (tagRepository.findByTagname(tag.getTagname()) != null) {
            return Response.newFailure("Username already taken");
        }
        tagRepository.save(tag);
        return Response.<Void>newSuccess(null, null);
    }

    
}