package com.annyarusova.russiantrip.repository;

import com.annyarusova.russiantrip.entity.RegionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegionRepository extends JpaRepository<RegionEntity, Integer> {
}
