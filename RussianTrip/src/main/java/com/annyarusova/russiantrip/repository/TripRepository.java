package com.annyarusova.russiantrip.repository;

import com.annyarusova.russiantrip.entity.TripEntity;
import org.springframework.data.jpa.repository.JpaRepository;


public interface TripRepository extends JpaRepository<TripEntity, Integer> {

}
