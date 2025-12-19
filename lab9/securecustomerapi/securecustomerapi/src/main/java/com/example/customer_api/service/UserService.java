package com.example.customer_api.service;

import com.example.customer_api.dto.LoginRequestDTO;
import com.example.customer_api.dto.LoginResponseDTO;
import com.example.customer_api.dto.RegisterRequestDTO;
import com.example.customer_api.dto.UserResponseDTO;
import com.example.customer_api.entity.Role;

import java.util.List;

import com.example.customer_api.dto.ChangePasswordDTO;
import com.example.customer_api.dto.ResetPasswordDTO;
import com.example.customer_api.dto.UpdateProfileDTO;

public interface UserService {
    
    LoginResponseDTO login(LoginRequestDTO loginRequest);
    
    UserResponseDTO register(RegisterRequestDTO registerRequest);
    
    UserResponseDTO getCurrentUser(String username);

    void changePassword(String username, ChangePasswordDTO dto);

    void forgotPassword(String email);

    void resetPassword(ResetPasswordDTO dto);

    UserResponseDTO getProfile(String username);

    UserResponseDTO updateProfile(String username, UpdateProfileDTO dto);

    void deleteAccount(String username, String password);

    List<UserResponseDTO> getAllUsers();

    UserResponseDTO updateUserRole(Long id, Role role);

    UserResponseDTO toggleUserStatus(Long id);

    LoginResponseDTO refreshAccessToken(String refreshToken);

}