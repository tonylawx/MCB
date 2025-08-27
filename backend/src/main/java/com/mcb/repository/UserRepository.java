package com.mcb.repository;

import com.mcb.model.User;
import org.apache.ibatis.annotations.*;

import java.util.Optional;

@Mapper
public interface UserRepository {
    
    @Select("SELECT id, email, password_hash FROM users WHERE email = #{email}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "email", column = "email"),
        @Result(property = "passwordHash", column = "password_hash")
    })
    Optional<User> findByEmail(String email);
    
    @Insert("INSERT INTO users (email, password_hash, created_at) VALUES (#{email}, #{passwordHash}, #{createdAt})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void insert(User user);
    
    @Select("SELECT id, email, password_hash, created_at FROM users WHERE id = #{id}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "email", column = "email"),
        @Result(property = "passwordHash", column = "password_hash"),
        @Result(property = "createdAt", column = "created_at", javaType = java.time.OffsetDateTime.class)
    })
    Optional<User> findById(Long id);
    
    @Select("SELECT EXISTS(SELECT 1 FROM users WHERE email = #{email})")
    boolean existsByEmail(String email);
}