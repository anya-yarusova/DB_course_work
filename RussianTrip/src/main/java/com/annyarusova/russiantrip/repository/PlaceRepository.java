package com.annyarusova.russiantrip.repository;

import com.annyarusova.russiantrip.entity.PlaceEntity;
import org.springframework.data.jpa.repository.JpaRepository;


public interface PlaceRepository extends JpaRepository<PlaceEntity, Integer> {

}
