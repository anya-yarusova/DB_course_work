package com.annyarusova.russiantrip.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@RequiredArgsConstructor
@Entity
@Table(name = "route_types")
public class RouteTypeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "route_type_id")
    private Integer routeTypeId;

    @Column(name = "alias", nullable = false, unique = true)
    private String alias;

    @Column(name = "description")
    private String description;
}
