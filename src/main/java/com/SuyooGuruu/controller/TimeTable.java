package com.SuyooGuruu.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.SuyooGuruu.dao.TeacherDAO;
import com.SuyooGuruu.dao.TimeTableDAO;
import com.SuyooGuruu.model.TeacherModel;
import com.SuyooGuruu.model.TimeTableModel;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/TimeTable"})
public class TimeTable extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TimeTableDAO timeTableDAO;
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        timeTableDAO = new TimeTableDAO();
        teacherDAO = new TeacherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Fetch all teachers for the filter dropdown
            List<TeacherModel> teachers = teacherDAO.getAllTeachers();
            request.setAttribute("teachers", teachers);

            // Get filter parameters
            String teacherIdStr = request.getParameter("teacherId");
            String day = request.getParameter("day");

            Long teacherId = null;
            if (teacherIdStr != null && !teacherIdStr.isEmpty()) {
                try {
                    teacherId = Long.parseLong(teacherIdStr);
                    request.setAttribute("selectedTeacherId", teacherId);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid Teacher ID.");
                }
            }
            if (day != null && !day.isEmpty()) {
                request.setAttribute("selectedDay", day);
            }

            // Fetch timetable entries based on filters
            List<TimeTableModel> timetables = timeTableDAO.getAllTimetables(teacherId, day);
            request.setAttribute("timetables", timetables);

            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Fetch form data
            String timetableIdStr = request.getParameter("timetableId");
            Long teacherId = Long.parseLong(request.getParameter("teacherId"));
            String day = request.getParameter("day");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String subject = request.getParameter("subject");
            String room = request.getParameter("room");

            // Basic validation
            if (teacherId == null || day == null || startTime == null || endTime == null || subject == null || room == null) {
                throw new IllegalArgumentException("All fields are required.");
            }

            TimeTableModel timetable;
            if (timetableIdStr == null || timetableIdStr.isEmpty()) {
                // Add new timetable entry
                timetable = new TimeTableModel(null, teacherId, null, day, startTime, endTime, subject, room);
                timeTableDAO.addTimetable(timetable);
            } else {
                // Update existing timetable entry
                Long timetableId = Long.parseLong(timetableIdStr);
                timetable = new TimeTableModel(timetableId, teacherId, null, day, startTime, endTime, subject, room);
                timeTableDAO.updateTimetable(timetable);
            }

            response.sendRedirect(request.getContextPath() + "/TimeTable");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            doGet(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input: " + e.getMessage());
            doGet(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
        }
    }
}