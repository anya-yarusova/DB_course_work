package com.annyarusova.russiantrip.dto;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@Getter
@Setter
@ToString
@EqualsAndHashCode
public class LoginContext implements Serializable {
    private boolean success;
    private UserPersonalData user;
    private String error;

    public LoginContext() {
        this.success = false;
        this.user = null;
        this.error = "Неверный логин или пароль";
    }

    public LoginContext(UserPersonalData user) {
        this.setSuccess(true);
        this.setUser(user);
    }

    public LoginContext(String error) {
        this.success = false;
        this.user = null;
        this.error = error;
    }
}
