package com.SuyooGuruu.dao;

import com.SuyooGuruu.config.DBConfig;
import com.SuyooGuruu.model.TimeTableModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

public class TimeTableDAO {

    private static final String INSERT_TIMETABLE_SQL = "INSERT INTO timetable (teacher_id, day, start_time, end_time, subject, room) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_TIMETABLE = "SELECT t.timetable_id, t.teacher_id, CONCAT(teachers.first_name, ' ', teachers.last_name) AS teacher_name, t.day, t.start_time, t.end_time, t.subject, t.room FROM timetable t JOIN teachers ON t.teacher_id = teachers.id WHERE 1=1";
    private static final String SELECT_TIMETABLE_BY_ID = "SELECT t.timetable_id, t.teacher_id, CONCAT(teachers.first_name, ' ', teachers.last_name) AS teacher_name, t.day, t.start_time, t.end_time, t.subject, t.room FROM timetable t JOIN teachers ON t.teacher_id = teachers.id WHERE t.timetable_id = ?";
    private static final String UPDATE_TIMETABLE_SQL = "UPDATE timetable SET teacher_id = ?, day = ?, start_time = ?, end_time = ?, subject = ?, room = ? WHERE timetable_id = ?";
    private static final String DELETE_TIMETABLE_SQL = "DELETE FROM timetable WHERE timetable_id = ?";

    public void addTimetable(TimeTableModel timetable) throws SQLException {
        try (Connection connection = DBConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TIMETABLE_SQL)) {
            preparedStatement.setLong(1, timetable.getTeacherId());
            preparedStatement.setString(2, timetable.getDay());
            preparedStatement.setTime(3, Time.valueOf(timetable.getStartTime() + ":00"));
            preparedStatement.setTime(4, Time.valueOf(timetable.getEndTime() + ":00"));
            preparedStatement.setString(5, timetable.getSubject());
            preparedStatement.setString(6, timetable.getRoom());
            preparedStatement.executeUpdate();
        }
    }

    public List<TimeTableModel> getAllTimetables(Long teacherId, String day) throws SQLException {
        List<TimeTableModel> timetables = new ArrayList<>();
        StringBuilder query = new StringBuilder(SELECT_ALL_TIMETABLE);
        List<Object> params = new ArrayList<>();

        if (teacherId != null && teacherId > 0) {
            query.append(" AND t.teacher_id = ?");
            params.add(teacherId);
        }
        if (day != null && !day.isEmpty()) {
            query.append(" AND t.day = ?");
            params.add(day);
        }

        try (Connection connection = DBConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                preparedStatement.setObject(i + 1, params.get(i));
            }
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                // Convert TIME to String by removing seconds
                String startTime = rs.getTime("start_time").toString().substring(0, 5);
                String endTime = rs.getTime("end_time").toString().substring(0, 5);

                TimeTableModel timetable = new TimeTableModel(
                    rs.getLong("timetable_id"),
                    rs.getLong("teacher_id"),
                    rs.getString("teacher_name"),
                    rs.getString("day"),
                    startTime,
                    endTime,
                    rs.getString("subject"),
                    rs.getString("room")
                );
                timetables.add(timetable);
            }
        }
        return timetables;
    }

    public TimeTableModel getTimetableById(Long id) throws SQLException {
        TimeTableModel timetable = null;
        try (Connection connection = DBConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TIMETABLE_BY_ID)) {
            preparedStatement.setLong(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                // Convert TIME to String by removing seconds
                String startTime = rs.getTime("start_time").toString().substring(0, 5);
                String endTime = rs.getTime("end_time").toString().substring(0, 5);

                timetable = new TimeTableModel(
                    rs.getLong("timetable_id"),
                    rs.getLong("teacher_id"),
                    rs.getString("teacher_name"),
                    rs.getString("day"),
                    startTime,
                    endTime,
                    rs.getString("subject"),
                    rs.getString("room")
                );
            }
        }
        return timetable;
    }

    public void updateTimetable(TimeTableModel timetable) throws SQLException {
        try (Connection connection = DBConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_TIMETABLE_SQL)) {
            preparedStatement.setLong(1, timetable.getTeacherId());
            preparedStatement.setString(2, timetable.getDay());
            preparedStatement.setTime(3, Time.valueOf(timetable.getStartTime() + ":00"));
            preparedStatement.setTime(4, Time.valueOf(timetable.getEndTime() + ":00"));
            preparedStatement.setString(5, timetable.getSubject());
            preparedStatement.setString(6, timetable.getRoom());
            preparedStatement.setLong(7, timetable.getId());
            preparedStatement.executeUpdate();
        }
    }

    public void deleteTimetable(Long id) throws SQLException {
        try (Connection connection = DBConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_TIMETABLE_SQL)) {
            preparedStatement.setLong(1, id);
            preparedStatement.executeUpdate();
        }
    }
}