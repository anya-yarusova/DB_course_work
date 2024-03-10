package com.annyarusova.russiantrip.repository;

import com.annyarusova.russiantrip.entity.TripStatusEntity;
import org.springframework.data.jpa.repository.JpaRepository;


public interface TripStatusRepository extends JpaRepository<TripStatusEntity, Integer> {

}
