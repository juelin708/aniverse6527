package com.example.aniverseapp.dao;

import org.springframework.data.jpa.repository.JpaRepository;

public interface AnimalRepository extends JpaRepository<Animal, Long> {
    Animal findByAnimalname(String animalname);
}
