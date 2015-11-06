package com.br.ideapp;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

/**
 * Created by matiii79 on 11/5/15.
 */
@Entity
public class Subscriber {

    @Id
    private String mailAddress;

    private String nickname;

    public Subscriber(){

    }

    public String getMailAddress() {
        return mailAddress;
    }

    public void setMailAddress(String mailAddress) {
        this.mailAddress = mailAddress;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
