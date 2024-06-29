package com.example.aniverseapp.converter;

import com.example.aniverseapp.dto.TagDTO;
import com.example.aniverseapp.dao.Tag;

public class TagConverter {

    public static TagDTO convertToTagDTO(Tag tag) {
        TagDTO tagDTO = new TagDTO();
        tagDTO.setTagname(tag.getTagname());
        return tagDTO;
    }

    public static Tag convertToEntity(TagDTO tagDTO) {
        Tag tag = new Tag();
        tag.setTagname(tagDTO.getTagname());
        return tag;
    }
}
