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
public class AccountDto implements Serializable {
    private String login;
    private String password;

    public AccountDto(String login, String password) {
        this.login = login;
        this.password = password;
    }
}
