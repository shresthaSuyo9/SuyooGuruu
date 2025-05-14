package com.SuyooGuruu.controller;

import com.SuyooGuruu.dao.TimeTableDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/DeleteTimetable"})
public class DeleteTimeTable extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final TimeTableDAO timetableDAO = new TimeTableDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            timetableDAO.deleteTimetable(id);
            response.sendRedirect("TimeTable");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("TimeTable?error=Invalid ID");
        }
    }
}