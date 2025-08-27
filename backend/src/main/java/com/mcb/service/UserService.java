package com.mcb.service;

import com.mcb.dto.AuthResponse;
import com.mcb.dto.UserLoginRequest;
import com.mcb.dto.UserRegistrationRequest;
import com.mcb.model.User;
import com.mcb.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.Optional;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    // @Autowired
    // private JwtService jwtService; // 暂时禁用JWT，等API版本兼容问题解决后再启用
    
    public AuthResponse registerUser(UserRegistrationRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        
        User user = new User();
        user.setEmail(request.getEmail());
        user.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        user.setCreatedAt(OffsetDateTime.now());
        
        userRepository.insert(user);
        
        String token = "jwt-token-" + user.getId(); // 简化的令牌，生产环境需要真正的JWT
        
        return new AuthResponse(token, user.getEmail(), user.getId());
    }
    
    public AuthResponse loginUser(UserLoginRequest request) {
        Optional<User> userOptional = userRepository.findByEmail(request.getEmail());
        
        if (userOptional.isEmpty()) {
            throw new RuntimeException("Invalid email or password");
        }
        
        User user = userOptional.get();
        
        if (!passwordEncoder.matches(request.getPassword(), user.getPasswordHash())) {
            throw new RuntimeException("Invalid email or password");
        }
        
        String token = "jwt-token-" + user.getId(); // 简化的令牌，生产环境需要真正的JWT
        
        return new AuthResponse(token, user.getEmail(), user.getId());
    }
    
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }
}