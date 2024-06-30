package com.example.aniverseapp.controller;

import com.example.aniverseapp.Response;
import com.example.aniverseapp.service.TagService;
import com.example.aniverseapp.dto.TagDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/tag")
public class TagController {

    @Autowired
    private TagService tagService;

    @GetMapping("/{id}")
    public Response<TagDTO> getTagById(@PathVariable long id) {
        return tagService.getTagById(id);
    }

    @GetMapping("/byTagname/{tagname}")
    public Response<TagDTO> getTagByTagname(@PathVariable String tagname) {
        return tagService.getTagByTagname(tagname);
    }

    @PostMapping("/add")
    public Response<Void> addTag(@RequestBody TagDTO tagDTO) {
        return tagService.addTag(tagDTO);
    }

    @DeleteMapping("/delete/{id}")
    public Response<Void> deleteTagById(@PathVariable long id) {
        return tagService.deleteTagById(id);
    }

    @PutMapping("/update/{id}")
    public Response<TagDTO> updateUserById(@PathVariable long id, @RequestParam String newTagname) {
        return tagService.updateTagById(id, newTagname);
    }
}
