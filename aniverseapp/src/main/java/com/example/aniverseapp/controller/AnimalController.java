package com.example.aniverseapp.controller;

import com.example.aniverseapp.dao.Animal;
import com.example.aniverseapp.dto.AnimalUpdateDTO;
import com.example.aniverseapp.service.AnimalService;
import com.example.aniverseapp.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;


@RestController
@RequestMapping("/api/animal")
public class AnimalController {

    @Autowired
    private AnimalService animalService;

    @PostMapping("/add")
    public Response<Animal> addAnimal(@RequestBody Animal animal) {
        return animalService.addAnimal(animal);
    }

    @GetMapping("/{id}")
    public Response<Animal> getAnimalById(@PathVariable Long id) {
        return animalService.getAnimalById(id);
    }

    @GetMapping("/byAnimalname/{name}")
    public Response<Animal> getAnimalByName(@PathVariable String name) {
        return animalService.getAnimalByName(name);
    }

    @PutMapping("/update/location/{id}")
    public Response<Animal> updateLocation(@PathVariable Long id, @RequestParam String location) {
        return animalService.updateLocation(id, location);
    }

    @PutMapping("/update/profile/{id}")
    public Response<Animal> updateAnimalProfile(@PathVariable long id, @RequestBody AnimalUpdateDTO animalDTO) {
        return animalService.updateAnimalProfile(id, animalDTO);
    }

    @GetMapping("all")
    public Response<List<Animal>> getAllAnimals() {
        return animalService.getAllAnimals();
    }
    
}
