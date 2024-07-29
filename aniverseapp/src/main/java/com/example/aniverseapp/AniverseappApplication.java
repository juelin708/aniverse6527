package com.example.aniverseapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan(basePackages = {"com.example.aniverseapp"})
@EnableJpaRepositories(basePackages = {"com.example.aniverseapp.dao"})
public class AniverseappApplication {
    public static void main(String[] args) {
        SpringApplication.run(AniverseappApplication.class, args);
    }
}
