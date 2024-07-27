package com.example.aniverseapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.aniverseapp.dao.Animal;
import com.example.aniverseapp.dao.AnimalRepository;
import com.example.aniverseapp.dto.AnimalUpdateDTO;
import com.example.aniverseapp.Response;

import java.util.Optional;
import java.util.List;

@Service
public class AnimalService {

    @Autowired
    private AnimalRepository animalRepository;

    public Response<Animal> addAnimal(Animal animal) {
        if (animalRepository.findByAnimalname(animal.getAnimalname()) != null) {
            return Response.newFailure("Animal name already taken");
        }
        animalRepository.save(animal);
        return Response.newSuccess(animal, "Animal added successfully");
    }

    public Response<Animal> getAnimalById(Long id) {
        if (animalRepository.findById(id).isEmpty()) {
            return Response.newFailure("Animal with id: " + id + " does not exist");
        }
        return Response.newSuccess(animalRepository.findById(id).get(), null) ;
    }

    public Response<Animal> getAnimalByName(String animalname) {
        if (animalRepository.findByAnimalname(animalname) == null) {
            return Response.newFailure("Animal with name: " + animalname + " does not exist");
        }
        return Response.newSuccess(animalRepository.findByAnimalname(animalname), null) ;
    }

    public Response<Animal> updateLocation(Long id, String location) {
        Optional<Animal> animalOpt = animalRepository.findById(id);
        if (animalOpt.isPresent()) {
            Animal animal = animalOpt.get();
            animal.setLocation(location);
            animalRepository.save(animal);
            return Response.newSuccess(animal, "Animal location updated successfully");
        } else {
            return Response.newFailure("Animal with id: " + id + " does not exist");
        }
    }

    public Response<Animal> updateAnimalProfile(long id, AnimalUpdateDTO animalDTO) {
        if (animalRepository.findById(id).isEmpty()) {
            return Response.newFailure("Animal with id: " + id + " does not exist");
        }
        Animal original = animalRepository.findById(id).orElse(null);
        if (animalDTO.getHabit() != null && animalDTO.getHabit().length() != 0) {
            original.setHabit(animalDTO.getHabit());
        }
        if (animalDTO.getHabitats() != null && animalDTO.getHabitats().length() != 0) {
            original.setHabitats(animalDTO.getHabitats());
        }
        if (animalDTO.getImageUrl() != null && animalDTO.getImageUrl().length() != 0) {
            original.setImageUrl(animalDTO.getImageUrl());
        }
        animalRepository.save(original);
        return Response.newSuccess(original, "Animal profile updated");
    }

    public Response<Void> deleteAnimalById(long id) {
        if (animalRepository.findById(id).isEmpty()) {
            return Response.newFailure("Animal with id: " + id + " does not exist");
        }
        animalRepository.deleteById(id);
        return Response.newSuccess(null, "Animal with id: " + id + " deleted");
    }

    public Response<List<Animal>> getAllAnimals() {
        return Response.newSuccess(animalRepository.findAll(), null);
    }
}
