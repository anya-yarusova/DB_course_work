package com.annyarusova.russiantrip.controller;

import com.annyarusova.russiantrip.service.VisitedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/regions")
@CrossOrigin
public class VisitedController {
    @Autowired
    private VisitedService visitedService;
    @PostMapping("/all")
    public ResponseEntity getAllRegions(@RequestParam String login) {
        try {
            return ResponseEntity.ok(visitedService.getRegionRepository(login));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.badRequest().body("Произошла ошибка во время выполнения запроса");
        }
    }

    @PostMapping("/visit")
    public ResponseEntity visitRegion(@RequestParam String login, @RequestParam Integer regionId) {
        try {
            visitedService.visitRegion(login, regionId);
            return ResponseEntity.ok("Регион посещен");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/unvisit")
    public ResponseEntity unvisitRegion(@RequestParam String login, @RequestParam Integer regionId) {
        try {
            visitedService.unvisitRegion(login, regionId);
            return ResponseEntity.ok("Регион удален из посещенных");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/percent")
    public ResponseEntity getPercent(@RequestParam String login) {
        try {
            return ResponseEntity.ok(visitedService.getVisitedPercent(login));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}
