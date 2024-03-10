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
@Table(name = "capitals")
public class RegionCapitalEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "capital_id")
    private Integer capitalId;

    @Column(name = "capital_name", nullable = false, unique = true)
    private String capitalName;

    @Column(name = "capital_location", columnDefinition = "POINT", nullable = false)
    private String capitalLocation;
}
