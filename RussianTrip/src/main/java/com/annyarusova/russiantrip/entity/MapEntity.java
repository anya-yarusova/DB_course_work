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
@Table(name = "maps")
public class MapEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "map_id")
    private Integer mapId;

    @OneToOne
    @JoinColumn(name = "login", nullable = false, unique = true)
    private UserEntity login;

    @Column(name = "creation_date", columnDefinition = "DATE", nullable = false)
    private LocalDate creationDate;

    @Column(name = "percent_visited", nullable = false)
    private int percentVisited;

    @ManyToOne
    @JoinColumn(name = "access_id", nullable = false)
    private AccessEntity accessId;

    @ManyToMany(cascade=CascadeType.ALL)
    @JoinTable(
            name = "visited",
            joinColumns = @JoinColumn(name = "map_id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "region_id", nullable = false)
    )
    private List<RegionEntity> regions;
}
