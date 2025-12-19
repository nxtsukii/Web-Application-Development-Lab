package com.example.customer_api.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.customer_api.dto.UpdateProfileDTO;
import com.example.customer_api.dto.UserResponseDTO;
import com.example.customer_api.service.UserService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    // View profile
    @GetMapping("/profile")
    public ResponseEntity<UserResponseDTO> getProfile() {

        String username = SecurityContextHolder.getContext()
                .getAuthentication()
                .getName();

        return ResponseEntity.ok(userService.getProfile(username));
    }

    // Update prof
    @PutMapping("/profile")
    public ResponseEntity<UserResponseDTO> updateProfile(
            @Valid @RequestBody UpdateProfileDTO dto) {

        String username = SecurityContextHolder.getContext()
                .getAuthentication()
                .getName();

        return ResponseEntity.ok(userService.updateProfile(username, dto));
    }

    // Delete
    @DeleteMapping("/account")
    public ResponseEntity<?> deleteAccount(@RequestParam String password) {

        String username = SecurityContextHolder.getContext()
                .getAuthentication()
                .getName();

        userService.deleteAccount(username, password);

        return ResponseEntity.ok(
            Map.of("message", "Account deactivated successfully")
        );
    }

}

