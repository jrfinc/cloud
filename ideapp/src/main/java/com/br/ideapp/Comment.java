package com.br.ideapp;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Parent;

/**
 * Created by jr on 10/15/15.
 */
@Entity
public class Comment {

    @Id
    private Long id;

    private String author_id;

    private String content;

    @Parent
    Key<Idea> parentKey;

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

    public Key<Idea> getParentKey() {
        return parentKey;
    }

    public void setParentKey(Key<Idea> parentKey) {
        this.parentKey = parentKey;
    }
}
