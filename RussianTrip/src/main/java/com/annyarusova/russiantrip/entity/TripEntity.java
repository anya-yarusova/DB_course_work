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
@Table(name = "trips")
public class TripEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trip_id")
    private Integer tripId;

    @ManyToOne
    @JoinColumn(name = "login", nullable = false)
    private UserEntity authorLogin;

    @Column(name = "name")
    private String name;

    @Column(name = "start_date", columnDefinition = "DATE", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", columnDefinition = "DATE", nullable = false)
    private LocalDate endDate;

    @Column(name = "description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "status_id", nullable = false)
    private TripStatusEntity statusId;

    @ManyToOne
    @JoinColumn(name = "access_id", nullable = false)
    private AccessEntity accessId;

    @ManyToMany()
    @JoinTable(
            name = "trip_routes",
            joinColumns = @JoinColumn(name = "trip_id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "route_id", nullable = false)
    )
    private List<RouteEntity> routes;

    @ManyToMany(mappedBy = "trips", cascade=CascadeType.ALL)
    private List<UserEntity> participation;
}
