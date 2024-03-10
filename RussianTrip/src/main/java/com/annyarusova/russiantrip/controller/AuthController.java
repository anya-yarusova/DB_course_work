package com.annyarusova.russiantrip.controller;

import com.annyarusova.russiantrip.dto.AccountDto;
import com.annyarusova.russiantrip.dto.LoginContext;
import com.annyarusova.russiantrip.dto.UserPersonalData;
import com.annyarusova.russiantrip.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@CrossOrigin
public class AuthController {
    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public ResponseEntity loginUser(@RequestBody AccountDto loginData) {
        try {
            UserPersonalData user = userService.login(loginData.getLogin(), loginData.getPassword());
            if (user == null)
                return ResponseEntity.badRequest().body(new LoginContext());
            else
                return ResponseEntity.ok(new LoginContext(user));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Произошла ошибка во время выполнения запроса");
        }
    }

    @PostMapping("/register")
    public ResponseEntity registerUser(@RequestBody UserPersonalData userData, @RequestParam String password) {
        try {
            boolean success = userService.register(userData, password);
            if (!success)
                return ResponseEntity.badRequest().body(new LoginContext("Пользователь с таким логином уже существует"));
            return ResponseEntity.ok(new LoginContext(userData));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Произошла ошибка во время выполнения запроса");
        }
    }

}
