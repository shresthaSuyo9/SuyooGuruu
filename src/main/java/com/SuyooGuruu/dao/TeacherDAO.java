package com.SuyooGuruu.dao;

import com.SuyooGuruu.model.TeacherModel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/suyooguruu";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_TEACHER_SQL = "INSERT INTO teachers (first_name, last_name, username, birthday, phone, email, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_TEACHER_BY_ID = "SELECT * FROM teachers WHERE id = ?";
    private static final String SELECT_ALL_TEACHERS = "SELECT * FROM teachers";
    private static final String DELETE_TEACHER_SQL = "DELETE FROM teachers WHERE id = ?";
    private static final String UPDATE_TEACHER_SQL = "UPDATE teachers SET first_name = ?, last_name = ?, username = ?, birthday = ?, phone = ?, email = ?, password = ? WHERE id = ?";
    private static final String SELECT_TEACHER_BY_USERNAME_OR_EMAIL = "SELECT * FROM teachers WHERE username = ? OR email = ? LIMIT 1";
    private static final String CHECK_USERNAME_EXISTS = "SELECT COUNT(*) FROM teachers WHERE username = ?";
    private static final String CHECK_EMAIL_EXISTS = "SELECT COUNT(*) FROM teachers WHERE email = ?";
    private static final String SEARCH_TEACHERS_BY_NAME = "SELECT * FROM teachers WHERE first_name LIKE ? OR last_name LIKE ?";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void addTeacher(TeacherModel teacher) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TEACHER_SQL)) {
            preparedStatement.setString(1, teacher.getFirstName());
            preparedStatement.setString(2, teacher.getLastName());
            preparedStatement.setString(3, teacher.getUsername());
            preparedStatement.setDate(4, teacher.getBirthday());
            preparedStatement.setString(5, teacher.getPhone());
            preparedStatement.setString(6, teacher.getEmail());
            preparedStatement.setString(7, teacher.getPassword());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public TeacherModel getTeacherById(Long id) {
        TeacherModel teacher = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TEACHER_BY_ID)) {
            preparedStatement.setLong(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                teacher = new TeacherModel();
                teacher.setId(rs.getLong("id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setLastName(rs.getString("last_name"));
                teacher.setUsername(rs.getString("username"));
                teacher.setBirthday(rs.getDate("birthday"));
                teacher.setPhone(rs.getString("phone"));
                teacher.setEmail(rs.getString("email"));
                teacher.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacher;
    }

    public List<TeacherModel> getAllTeachers() {
        List<TeacherModel> teachers = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TEACHERS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                TeacherModel teacher = new TeacherModel();
                teacher.setId(rs.getLong("id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setLastName(rs.getString("last_name"));
                teacher.setUsername(rs.getString("username"));
                teacher.setBirthday(rs.getDate("birthday"));
                teacher.setPhone(rs.getString("phone"));
                teacher.setEmail(rs.getString("email"));
                teacher.setPassword(rs.getString("password"));
                teachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }

    public void updateTeacher(TeacherModel teacher) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_TEACHER_SQL)) {
            preparedStatement.setString(1, teacher.getFirstName());
            preparedStatement.setString(2, teacher.getLastName());
            preparedStatement.setString(3, teacher.getUsername());
            preparedStatement.setDate(4, teacher.getBirthday());
            preparedStatement.setString(5, teacher.getPhone());
            preparedStatement.setString(6, teacher.getEmail());
            preparedStatement.setString(7, teacher.getPassword());
            preparedStatement.setLong(8, teacher.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTeacher(Long id) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_TEACHER_SQL)) {
            preparedStatement.setLong(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public TeacherModel getTeacherByUsernameOrEmail(String usernameOrEmail) {
        TeacherModel teacher = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TEACHER_BY_USERNAME_OR_EMAIL)) {
            preparedStatement.setString(1, usernameOrEmail);
            preparedStatement.setString(2, usernameOrEmail);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                teacher = new TeacherModel();
                teacher.setId(rs.getLong("id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setLastName(rs.getString("last_name"));
                teacher.setUsername(rs.getString("username"));
                teacher.setBirthday(rs.getDate("birthday"));
                teacher.setPhone(rs.getString("phone"));
                teacher.setEmail(rs.getString("email"));
                teacher.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacher;
    }
    public boolean isUsernameExists(String username) {
        boolean exists = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CHECK_USERNAME_EXISTS)) {
            preparedStatement.setString(1, username);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }
    public boolean isEmailExists(String email) {
        boolean exists = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CHECK_EMAIL_EXISTS)) {
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }
    public List<TeacherModel> searchTeachersByName(String searchName) {
        List<TeacherModel> teachers = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_TEACHERS_BY_NAME)) {
            String searchPattern = "%" + searchName + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                TeacherModel teacher = new TeacherModel();
                teacher.setId(rs.getLong("id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setLastName(rs.getString("last_name"));
                teacher.setUsername(rs.getString("username"));
                teacher.setBirthday(rs.getDate("birthday"));
                teacher.setPhone(rs.getString("phone"));
                teacher.setEmail(rs.getString("email"));
                teacher.setPassword(rs.getString("password"));
                teachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
}