package com.annyarusova.russiantrip.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;
import java.util.List;


@Getter
@Setter
@ToString
@RequiredArgsConstructor
@Entity
@Table(name = "users")
public class UserEntity {
    @Id
    @Column(name = "login")
    private String login;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "surname", nullable = false)
    private String surname;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "birt_date", columnDefinition = "DATE")
    private LocalDate birtDate;

    @ManyToMany(cascade=CascadeType.ALL)
    @JoinTable(
            name = "friends",
            joinColumns = @JoinColumn(name = "user1_login", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "user2_login", nullable = false)
    )
    private List<UserEntity> friends;

    @ManyToMany()
    @JoinTable(
            name = "participation",
            joinColumns = @JoinColumn(name = "user_login", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "trip_id", nullable = false)
    )
    private List<TripEntity> trips;
}
