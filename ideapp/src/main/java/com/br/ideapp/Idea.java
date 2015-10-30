package com.br.ideapp;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

import java.util.Date;
import java.util.List;

/**
 * Created by jr on 10/15/15.
 */
@Entity
public class Idea {

    @Id
    private Long id;

    @Index
    private String author_id;
    private String content;

    @Index
    private Date date;

    public Idea() {
    }

    public Long getId() {
        return id;
    }

    public String getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(String author_id) {
        this.author_id = author_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}