package com.SuyooGuruu.dao;

import com.SuyooGuruu.model.TeacherModel;
import com.SuyooGuruu.model.TimeTableModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TimeTableDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/suyooguruu_db?useSSL=false";
    private static final String DB_USER = "root"; // Replace with your DB username
    private static final String DB_PASSWORD = ""; // Replace with your DB password

    // Get all teachers for dropdown
    public List<TeacherModel> getAllTeachers() throws SQLException {
        List<TeacherModel> teachers = new ArrayList<>();
        String sql = "SELECT TeacherID, FirstName, LastName FROM Teacher ORDER BY FirstName, LastName";
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                TeacherModel teacher = new TeacherModel();
                teacher.setId(rs.getLong("TeacherID"));
                teacher.setFirstName(rs.getString("FirstName"));
                teacher.setLastName(rs.getString("LastName"));
                teachers.add(teacher);
            }
        }
        return teachers;
    }

    // Get filtered timetable entries
    public List<TimeTableModel> getTimetables(Long teacherId, String day) throws SQLException {
        List<TimeTableModel> timetables = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT t.TimeTableID, t.TeacherID, t.Day, t.StartTime, t.EndTime, t.Subject, t.Room, " +
            "CONCAT(tchr.FirstName, ' ', tchr.LastName) AS TeacherName " +
            "FROM TIMETABLE t " +
            "LEFT JOIN Teacher tchr ON t.TeacherID = tchr.TeacherID"
        );
        List<Object> params = new ArrayList<>();
        boolean whereAdded = false;

        if (teacherId != null) {
            sql.append(" WHERE t.TeacherID = ?");
            params.add(teacherId);
            whereAdded = true;
        }
        if (day != null && !day.isEmpty()) {
            sql.append(whereAdded ? " AND" : " WHERE").append(" t.Day = ?");
            params.add(day);
        }
        sql.append(" ORDER BY t.Day, t.StartTime");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    TimeTableModel timetable = new TimeTableModel(
                        rs.getLong("TimeTableID"),
                        rs.getLong("TeacherID"),
                        rs.getString("TeacherName"),
                        rs.getString("Day"),
                        rs.getString("StartTime"),
                        rs.getString("EndTime"),
                        rs.getString("Subject"),
                        rs.getString("Room")
                    );
                    timetables.add(timetable);
                }
            }
        }
        return timetables;
    }

    // Save or update timetable entry
    public void saveTimetable(TimeTableModel timetable) throws SQLException {
        String sql = timetable.getId() == null || timetable.getId() == 0 ?
            "INSERT INTO TIMETABLE (TeacherID, Day, StartTime, EndTime, Subject, Room) VALUES (?, ?, ?, ?, ?, ?)" :
            "UPDATE TIMETABLE SET TeacherID = ?, Day = ?, StartTime = ?, EndTime = ?, Subject = ?, Room = ? WHERE TimeTableID = ?";
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, timetable.getTeacherId());
            stmt.setString(2, timetable.getDay());
            stmt.setString(3, timetable.getStartTime());
            stmt.setString(4, timetable.getEndTime());
            stmt.setString(5, timetable.getSubject());
            stmt.setString(6, timetable.getRoom());
            if (timetable.getId() != null && timetable.getId() != 0) {
                stmt.setLong(7, timetable.getId());
            }
            stmt.executeUpdate();
        }
    }

    // Delete timetable entry
    public void deleteTimetable(Long id) throws SQLException {
        String sql = "DELETE FROM TIMETABLE WHERE TimeTableID = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}