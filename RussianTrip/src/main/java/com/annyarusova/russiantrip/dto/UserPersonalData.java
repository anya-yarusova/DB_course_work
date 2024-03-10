package com.annyarusova.russiantrip.dto;

import com.annyarusova.russiantrip.entity.UserEntity;
import lombok.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@ToString
@RequiredArgsConstructor
@EqualsAndHashCode
public class UserPersonalData implements Serializable {
    private String login;
    private String name;
    private String surname;
    private LocalDate birtDate;
    private List<UserPersonalData> friends;

    public UserPersonalData(UserEntity user) {
        this.setName(user.getName());
        this.setSurname(user.getSurname());
        this.setBirtDate(user.getBirtDate());
        this.setLogin(user.getLogin());
        this.setFriends(user.getFriends());
    }

    private void setFriends(List<UserEntity> friends) {
        this.friends = friends.stream().map(UserPersonalData::new).toList();
    }
}
