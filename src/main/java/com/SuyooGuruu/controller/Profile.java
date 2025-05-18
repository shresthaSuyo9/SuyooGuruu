package com.SuyooGuruu.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.SuyooGuruu.model.TeacherModel;
import java.io.IOException;
import java.sql.Date;
import java.util.regex.Pattern;

@WebServlet(asyncSupported = true, urlPatterns = { "/Profile" })
public class Profile extends HttpServlet {
    private static final long serialVersionUID = 5L;

    public Profile() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve or initialize teacher profile from session
        TeacherModel teacher = (TeacherModel) request.getSession().getAttribute("teacherProfile");
        if (teacher == null) {
            // Initialize default profile for Deepak Bajracharya
            teacher = new TeacherModel();
            teacher.setId(5L);
            teacher.setFirstName("Deepak");
            teacher.setLastName("Bajracharya");
            teacher.setUsername("DEEPAK");
            teacher.setEmail("DEePak@gmail.com");
            teacher.setPhone("9851124760");
            teacher.setBirthday(Date.valueOf("2000-06-19"));
            teacher.setPassword("password123");
            request.getSession().setAttribute("teacherProfile", teacher);
        }

        // Always set teacher in the request
        request.setAttribute("teacher", teacher);
        request.getRequestDispatcher("WEB-INF/Pages/Profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve existing teacher from session
        TeacherModel teacher = (TeacherModel) request.getSession().getAttribute("teacherProfile");
        if (teacher == null) {
        	teacher = new TeacherModel();
            teacher.setId(5L);
            teacher.setFirstName("Deepak");
            teacher.setLastName("Bajracharya");
            teacher.setUsername("DEEPAK");
            teacher.setEmail("DEePak@gmail.com");
            teacher.setPhone("9851124760");
            teacher.setBirthday(Date.valueOf("2000-06-19"));
            teacher.setPassword("password123");
            request.getSession().setAttribute("teacherProfile", teacher);
        }

        try {
            // Update teacher with form data
            teacher.setFirstName(request.getParameter("firstName"));
            teacher.setLastName(request.getParameter("lastName"));
            teacher.setUsername(request.getParameter("username"));
            teacher.setPhone(request.getParameter("phone"));

            // Validate and set email
            String email = request.getParameter("email");
            if (email != null && Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", email)) {
                teacher.setEmail(email);
            } else {
                throw new IllegalArgumentException("Invalid email format.");
            }

            // Handle birthday with validation
            String birthdayStr = request.getParameter("birthday");
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                try {
                    teacher.setBirthday(Date.valueOf(birthdayStr));
                } catch (IllegalArgumentException e) {
                    throw new IllegalArgumentException("Invalid birthday format. Use YYYY-MM-DD.");
                }
            } else {
                teacher.setBirthday(null);
            }

            // Handle password update
            String newPassword = request.getParameter("newPassword");
            String oldPassword = request.getParameter("oldPassword");
            if (oldPassword != null && !oldPassword.isEmpty() && newPassword != null && !newPassword.isEmpty()) {
                if (oldPassword.equals(teacher.getPassword())) {
                    teacher.setPassword(newPassword);
                    request.setAttribute("message", "Password updated successfully!");
                } else {
                    throw new IllegalArgumentException("Old password does not match.");
                }
            }

            // Save updated teacher to session
            request.getSession().setAttribute("teacherProfile", teacher);

            // Success message
            request.setAttribute("message", "Profile updated successfully!");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "Failed to update profile: " + e.getMessage());
        }

        // Always set teacher in the request, even if an exception occurs
        request.setAttribute("teacher", teacher);
        request.getRequestDispatcher("WEB-INF/Pages/Profile.jsp").forward(request, response);
    }
}