package com.annyarusova.russiantrip.controller;

import com.annyarusova.russiantrip.dto.LoginContext;
import com.annyarusova.russiantrip.dto.UserPersonalData;
import com.annyarusova.russiantrip.service.FriendService;
import com.annyarusova.russiantrip.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/friends")
@CrossOrigin
public class FriendController {
    @Autowired
    private FriendService friendService;
    @PostMapping("/add")
    public ResponseEntity addFriend(@RequestParam String user, @RequestParam String friendLogin) {
        try {
            friendService.addFriend(user, friendLogin);
            return ResponseEntity.ok("Друг успешно добавлен");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/remove")
    public ResponseEntity removeFriend(@RequestParam String user, @RequestParam String friendLogin) {
        try {
            friendService.removeFriend(user, friendLogin);
            return ResponseEntity.ok("Друг успешно удален");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/all")
    public ResponseEntity getFriends(@RequestParam String user) {
        try {
            return ResponseEntity.ok(friendService.getFriends(user));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}
