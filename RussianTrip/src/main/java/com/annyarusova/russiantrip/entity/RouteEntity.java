package com.annyarusova.russiantrip.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;
import java.util.List;


@Getter
@Setter
@ToString
@RequiredArgsConstructor
@Entity
@Table(name = "routes")
public class RouteEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "route_id")
    private Integer routeId;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "start_time", columnDefinition = "DATETIME", nullable = false)
    private LocalDateTime startTime;

    @Column(name = "end_time", columnDefinition = "DATETIME", nullable = false)
    private LocalDateTime endTime;

    @ManyToOne
    @JoinColumn(name = "type_id")
    private RouteTypeEntity routeTypeId;

    @ManyToOne
    @JoinColumn(name = "access_id", nullable = false)
    private AccessEntity accessId;

    @ManyToMany(mappedBy = "routes", cascade=CascadeType.ALL)
    private List<TripEntity> trips;

    @ManyToMany(mappedBy = "routes", cascade=CascadeType.ALL)
    private List<PlaceEntity> places;
}
