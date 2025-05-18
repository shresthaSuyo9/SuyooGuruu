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

@WebServlet(urlPatterns = {"/TimeTable", "/TimeTable/add", "/TimeTable/edit", "/TimeTable/delete"})
public class TimeTable extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TimeTableDAO timeTableDAO;
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        try {
            timeTableDAO = new TimeTableDAO();
            teacherDAO = new TeacherDAO();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize DAOs: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/TimeTable":
                    listTimetables(request, response);
                    break;
                case "/TimeTable/add":
                    showAddForm(request, response);
                    break;
                case "/TimeTable/edit":
                    showEditForm(request, response);
                    break;
                case "/TimeTable/delete":
                    deleteTimetable(request, response);
                    break;
                default:
                    listTimetables(request, response);
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/TimeTable/add":
                    addTimetable(request, response);
                    break;
                case "/TimeTable/edit":
                    updateTimetable(request, response);
                    break;
                default:
                    listTimetables(request, response);
                    break;
            }
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

    private void listTimetables(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
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
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<TeacherModel> teachers = teacherDAO.getAllTeachers();
        request.setAttribute("teachers", teachers);
        request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response); // Assuming form is part of the same JSP
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        Long id = Long.parseLong(request.getParameter("id"));
        TimeTableModel timetable = timeTableDAO.getTimetableById(id);
        if (timetable != null) {
            request.setAttribute("timetable", timetable);
            List<TeacherModel> teachers = teacherDAO.getAllTeachers();
            request.setAttribute("teachers", teachers);
            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response); // Assuming edit form is part of the same JSP
        } else {
            request.setAttribute("error", "Timetable entry not found.");
            listTimetables(request, response);
        }
    }

    private void addTimetable(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, SQLException {
        TimeTableModel timetable = new TimeTableModel();
        timetable.setTeacherId(Long.parseLong(request.getParameter("teacherId")));
        timetable.setDay(request.getParameter("day"));
        timetable.setStartTime(request.getParameter("startTime"));
        timetable.setEndTime(request.getParameter("endTime"));
        timetable.setSubject(request.getParameter("subject"));
        timetable.setRoom(request.getParameter("room"));

        // Basic validation
        if (timetable.getTeacherId() == null || timetable.getDay() == null || timetable.getStartTime() == null ||
            timetable.getEndTime() == null || timetable.getSubject() == null || timetable.getRoom() == null) {
            throw new IllegalArgumentException("All fields are required.");
        }

        timeTableDAO.addTimetable(timetable);
        response.sendRedirect(request.getContextPath() + "/TimeTable");
    }

    private void updateTimetable(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, SQLException {
        TimeTableModel timetable = new TimeTableModel();
        timetable.setId(Long.parseLong(request.getParameter("timetableId")));
        timetable.setTeacherId(Long.parseLong(request.getParameter("teacherId")));
        timetable.setDay(request.getParameter("day"));
        timetable.setStartTime(request.getParameter("startTime"));
        timetable.setEndTime(request.getParameter("endTime"));
        timetable.setSubject(request.getParameter("subject"));
        timetable.setRoom(request.getParameter("room"));

        // Basic validation
        if (timetable.getId() == null || timetable.getTeacherId() == null || timetable.getDay() == null ||
            timetable.getStartTime() == null || timetable.getEndTime() == null || timetable.getSubject() == null ||
            timetable.getRoom() == null) {
            throw new IllegalArgumentException("All fields are required.");
        }

        timeTableDAO.updateTimetable(timetable);
        response.sendRedirect(request.getContextPath() + "/TimeTable");
    }

    private void deleteTimetable(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, SQLException {
        Long id = Long.parseLong(request.getParameter("id"));
        timeTableDAO.deleteTimetable(id);
        response.sendRedirect(request.getContextPath() + "/TimeTable");
    }
}