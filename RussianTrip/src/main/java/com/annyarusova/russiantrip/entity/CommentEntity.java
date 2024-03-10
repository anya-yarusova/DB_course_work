package com.annyarusova.russiantrip.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;


@Getter
@Setter
@ToString
@RequiredArgsConstructor
@Entity
@Table(name = "comments")
public class CommentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private Integer commentId;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "rate_numeric")
    private Integer ratingNumeric;

    @Column(name = "comment_date", columnDefinition = "DATE")
    private LocalDate commentDate;

    @ManyToOne
    @JoinColumn(name = "author_login", nullable = false, unique = true)
    private UserEntity authorLogin;

    @ManyToOne
    @JoinColumn(name = "place_id")
    private PlaceEntity placeId;

    @ManyToOne
    @JoinColumn(name = "trip_id")
    private TripEntity tripId;

    @ManyToOne
    @JoinColumn(name = "route_id")
    private RouteEntity routeId;
}
