package com.br.ideapp;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

/**
 * Created by jr on 10/15/15.
 */
@Entity
public class Comment {

    @Id
    private Long id;

    private String author_id;

    private String content;

    public Comment() {
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
}
