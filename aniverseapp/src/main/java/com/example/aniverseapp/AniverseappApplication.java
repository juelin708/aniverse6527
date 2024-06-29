package com.example.aniverseapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories("com.example.aniverseapp.dao")
public class AniverseappApplication {
    public static void main(String[] args) {
        SpringApplication.run(AniverseappApplication.class, args);
    }
}
