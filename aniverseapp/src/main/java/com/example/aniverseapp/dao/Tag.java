package com.example.aniverseapp.dao;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import static jakarta.persistence.GenerationType.IDENTITY;


@Entity
@Table(name="tags")
public class Tag {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = IDENTITY)
    private long id;

    @Column(name = "tagname")
    private String tagname;
    
    // Getters and setters
    public long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTagname() {
        return tagname;
    }

    public void setTagname(String tagname) {
        this.tagname = tagname;
    }
}
