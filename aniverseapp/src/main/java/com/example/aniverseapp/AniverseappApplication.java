package com.example.aniverseapp;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.example.aniverseapp.mapper")
public class AniverseappApplication {
    public static void main(String[] args) {
        SpringApplication.run(AniverseappApplication.class, args);
    }
}
