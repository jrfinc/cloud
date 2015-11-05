package com.br.ideapp;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

/**
 * Created by matiii79 on 10/29/15.
 */
@Entity
public class Vote {

    @Id
    private String id;

    @Index
    private Long ideaId;

    private String userId;

    private int vote;

    public Vote(Long ideaId, String userId, int vote) {
        this.ideaId = ideaId;
        this.userId = userId;
        this.id = ideaId + "-" + userId;
        this.vote = vote;
    }

    public Vote() {

    }

    public Long getIdeaId() {
        return ideaId;
    }

    public String getUserId() {
        return userId;
    }

    public int getVote() {
        return vote;
    }
}
