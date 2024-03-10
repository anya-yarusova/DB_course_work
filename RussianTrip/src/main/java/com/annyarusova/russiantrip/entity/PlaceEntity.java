package com.annyarusova.russiantrip.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;


@Getter
@Setter
@ToString
@RequiredArgsConstructor
@Entity
@Table(name = "places")
public class PlaceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "place_id")
    private Integer placeId;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "location", columnDefinition = "POINT")
    private String location;

    @Column(name = "amount_comments")
    private Integer amountComments;

    @Column(name = "rating_numeric")
    private Integer ratingNumeric;

    @ManyToOne
    @JoinColumn(name = "access_id", nullable = false)
    private AccessEntity accessId;

    @ManyToMany()
    @JoinTable(
            name = "route_places",
            joinColumns = @JoinColumn(name = "place_id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "route_id", nullable = false)
    )
    private List<RouteEntity> routes;
}
