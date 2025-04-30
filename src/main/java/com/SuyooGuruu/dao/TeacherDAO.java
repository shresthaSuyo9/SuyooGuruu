package com.SuyooGuruu.dao;

import com.SuyooGuruu.config.DBConfig;
import com.SuyooGuruu.model.TeacherModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TeacherDAO {
    public void registerTeacher(TeacherModel teacher) throws SQLException {
        String sql = "INSERT INTO Teachers (first_name, last_name, username, birthday, phone, email, password) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, teacher.getFirstName());
            pstmt.setString(2, teacher.getLastName());
            pstmt.setString(3, teacher.getUsername());
            pstmt.setDate(4, teacher.getBirthday());
            pstmt.setString(5, teacher.getPhone());
            pstmt.setString(6, teacher.getEmail());
            pstmt.setString(7, teacher.getPassword());
            
            pstmt.executeUpdate();
        }
    }

    public boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Teachers WHERE username = ?";
        
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        }
    }

    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Teachers WHERE email = ?";
        
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        }
    }
    
    public TeacherModel getTeacherByUsernameOrEmail(String usernameOrEmail) throws SQLException {
        String sql = "SELECT * FROM Teachers WHERE username = ? OR email = ?";
        
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, usernameOrEmail);
            pstmt.setString(2, usernameOrEmail);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                TeacherModel teacher = new TeacherModel();
                teacher.setId(rs.getLong("id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setLastName(rs.getString("last_name"));
                teacher.setUsername(rs.getString("username"));
                teacher.setBirthday(rs.getDate("birthday"));
                teacher.setPhone(rs.getString("phone"));
                teacher.setEmail(rs.getString("email"));
                teacher.setPassword(rs.getString("password"));
                return teacher;
            }
            return null;
        }
    }
}