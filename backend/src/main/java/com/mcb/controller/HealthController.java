package com.mcb.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * Health Check Controller
 * Provides basic application health status endpoints
 */
@RestController
public class HealthController {

    /**
     * Basic health check endpoint
     * Docker health checks will call this endpoint
     */
    @GetMapping("/health")
    public Map<String, Object> health() {
        Map<String, Object> status = new HashMap<>();
        status.put("status", "UP");
        status.put("service", "mcb-backend");
        status.put("version", "0.1.0");
        status.put("timestamp", System.currentTimeMillis());
        return status;
    }
    
}