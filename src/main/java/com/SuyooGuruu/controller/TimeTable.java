package com.SuyooGuruu.controller;

import com.SuyooGuruu.dao.TimeTableDAO;
import com.SuyooGuruu.model.TeacherModel;
import com.SuyooGuruu.model.TimeTableModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/TimeTable"})
public class TimeTable extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final TimeTableDAO timetableDAO = new TimeTableDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get filter parameters
            Long teacherId = request.getParameter("teacherId") != null && !request.getParameter("teacherId").isEmpty() ?
                Long.parseLong(request.getParameter("teacherId")) : null;
            String day = request.getParameter("day");

            // Fetch data
            List<TeacherModel> teachers = timetableDAO.getAllTeachers();
            List<TimeTableModel> timetables = timetableDAO.getTimetables(teacherId, day);

            // Set attributes for JSP
            request.setAttribute("teachers", teachers);
            request.setAttribute("timetables", timetables);
            request.setAttribute("selectedTeacherId", teacherId);
            request.setAttribute("selectedDay", day);

            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Extract form data
            Long id = request.getParameter("timetableId") != null && !request.getParameter("timetableId").isEmpty() ?
                Long.parseLong(request.getParameter("timetableId")) : null;
            Long teacherId = Long.parseLong(request.getParameter("teacherId"));
            String day = request.getParameter("day");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String subject = request.getParameter("subject");
            String room = request.getParameter("room");

            // Basic validation
            if (teacherId == null || day.isEmpty() || startTime.isEmpty() || endTime.isEmpty() || subject.isEmpty() || room.isEmpty()) {
                request.setAttribute("error", "All fields are required");
                doGet(request, response);
                return;
            }

            // Create and save timetable
            TimeTableModel timetable = new TimeTableModel(id, teacherId, null, day, startTime, endTime, subject, room);
            timetableDAO.saveTimetable(timetable);

            // Redirect to avoid form resubmission
            response.sendRedirect("TimeTable");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            doGet(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input");
            doGet(request, response);
        }
    }
}