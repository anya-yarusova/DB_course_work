package com.annyarusova.russiantrip.repository;

import com.annyarusova.russiantrip.entity.PhotoEntity;
import org.springframework.data.jpa.repository.JpaRepository;


public interface PhotoRepository extends JpaRepository<PhotoEntity, Integer> {

}
