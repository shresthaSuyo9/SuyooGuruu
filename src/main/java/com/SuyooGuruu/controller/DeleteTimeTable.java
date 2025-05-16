package com.SuyooGuruu.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.SuyooGuruu.dao.TimeTableDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/DeleteTimetable"})
public class DeleteTimeTable extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TimeTableDAO timeTableDAO;

    @Override
    public void init() throws ServletException {
        timeTableDAO = new TimeTableDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            timeTableDAO.deleteTimetable(id);
            response.sendRedirect(request.getContextPath() + "/TimeTable");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid timetable ID: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Pages/TimeTable.jsp").forward(request, response);
        }
    }
}