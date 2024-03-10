package com.annyarusova.russiantrip.service;

import com.annyarusova.russiantrip.dto.UserPersonalData;
import com.annyarusova.russiantrip.entity.UserEntity;
import com.annyarusova.russiantrip.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public UserPersonalData login(String login, String password) {
        Optional<UserEntity> account = userRepository.findByLogin(login);
        if (account.isPresent() && Objects.equals(account.get().getPassword(), password))
            return new UserPersonalData(account.get());
        else
            return null;
    }

    public boolean register(UserPersonalData userPersonalData, String password) {
        if (userRepository.findByLogin(userPersonalData.getLogin()).isPresent())
            return false;
        userRepository.save(mapToUserEntity(userPersonalData, password));
        return true;
    }

    private UserEntity mapToUserEntity(UserPersonalData userPersonalData, String password) {
        UserEntity userEntity = new UserEntity();
        userEntity.setLogin(userPersonalData.getLogin());
        userEntity.setName(userPersonalData.getName());
        userEntity.setSurname(userPersonalData.getSurname());
        userEntity.setBirtDate(userPersonalData.getBirtDate());
        userEntity.setPassword(password);
        return userEntity;
    }
}
