package com.annyarusova.russiantrip.service;

import com.annyarusova.russiantrip.dto.RegionDto;
import com.annyarusova.russiantrip.entity.MapEntity;
import com.annyarusova.russiantrip.entity.RegionEntity;
import com.annyarusova.russiantrip.entity.UserEntity;
import com.annyarusova.russiantrip.repository.MapRepository;
import com.annyarusova.russiantrip.repository.RegionRepository;
import com.annyarusova.russiantrip.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class VisitedService {
    @Autowired
    private RegionRepository regionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MapRepository mapRepository;

    public List<RegionDto> getRegionRepository(String login) {
        Optional<UserEntity> user = userRepository.findByLogin(login);
        if (user.isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        Optional<MapEntity> map = mapRepository.findByLogin(user.get());
        if (map.isEmpty()) {
            throw new IllegalArgumentException("Карта пользователя не найдена");
        }
        List<RegionEntity> visitedRegions = map.get().getRegions();
        List<RegionEntity> regions = regionRepository.findAll();

        return regions.stream().map(region -> ToDto(region, visitedRegions.contains(region))).collect(Collectors.toList());
    }

    public void visitRegion(String login, Integer regionId) {
        Optional<UserEntity> user = userRepository.findByLogin(login);
        if (user.isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        Optional<MapEntity> map = mapRepository.findByLogin(user.get());
        if (map.isEmpty()) {
            throw new IllegalArgumentException("Карта пользователя не найдена");
        }
        RegionEntity region = regionRepository.findById(regionId).orElseThrow(() -> new IllegalArgumentException("Регион не найден"));
        if (map.get().getRegions().contains(region)) {
            throw new IllegalArgumentException("Регион уже посещен");
        }
        map.get().getRegions().add(region);
        mapRepository.save(map.get());
    }

    public void unvisitRegion(String login, Integer regionId) {
        Optional<UserEntity> user = userRepository.findByLogin(login);
        if (user.isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        Optional<MapEntity> map = mapRepository.findByLogin(user.get());
        if (map.isEmpty()) {
            throw new IllegalArgumentException("Карта пользователя не найдена");
        }
        RegionEntity region = regionRepository.findById(regionId).orElseThrow(() -> new IllegalArgumentException("Регион не найден"));
        if (!map.get().getRegions().contains(region)) {
            throw new IllegalArgumentException("Регион не посещен");
        }
        map.get().getRegions().remove(region);
        mapRepository.save(map.get());
    }

    public double getVisitedPercent(String login) {
        Optional<UserEntity> user = userRepository.findByLogin(login);
        if (user.isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        Optional<MapEntity> map = mapRepository.findByLogin(user.get());
        if (map.isEmpty()) {
            throw new IllegalArgumentException("Карта пользователя не найдена");
        }
        List<RegionEntity> visitedRegions = map.get().getRegions();
        List<RegionEntity> regions = regionRepository.findAll();
        return (visitedRegions.size() * 100.0 / regions.size());
    }

    private RegionDto ToDto(RegionEntity entity, boolean visited) {
        return new RegionDto(entity.getRegionId(), entity.getName(), entity.getCapitalId().getCapitalName(), entity.getCapitalId().getCapitalLocation().toString(), visited);
    }
}
