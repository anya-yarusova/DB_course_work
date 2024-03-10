package com.annyarusova.russiantrip.repository;

import com.annyarusova.russiantrip.entity.MapEntity;
import com.annyarusova.russiantrip.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface MapRepository extends JpaRepository<MapEntity, Integer> {

    Optional<MapEntity> findByLogin(UserEntity login);
}
