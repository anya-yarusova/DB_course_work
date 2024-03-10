package com.annyarusova.russiantrip.dto;

import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@AllArgsConstructor
public class RegionDto implements Serializable {
    Integer regionId;
    String name;
    String capitalName;
    String capitalLocation;
    boolean visited;
}
