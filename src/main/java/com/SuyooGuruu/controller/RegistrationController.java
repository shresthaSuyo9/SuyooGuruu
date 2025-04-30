package com.SuyooGuruu.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.SuyooGuruu.dao.TeacherDAO;
import com.SuyooGuruu.model.TeacherModel;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

/**
 * Servlet implementation class RegistrationController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
public class RegistrationController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO teacherDAO;

    public void init() {
        teacherDAO = new TeacherDAO();
    }

    public RegistrationController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Initialize session if it doesn't exist
        HttpSession session = request.getSession(true);
        
        // Check if user is already logged in
        if (session.getAttribute("loggedInUser") != null) {
            // Redirect to dashboard if already logged in
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        request.getRequestDispatcher("WEB-INF/Pages/SuyoGuruu_Registration_Page.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get or create session
        HttpSession session = request.getSession(true);
        
        // Set session timeout (30 minutes)
        session.setMaxInactiveInterval(30*60);
        
        // Fetch form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String birthday = request.getParameter("birthday");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String retypePassword = request.getParameter("retypePassword");

        // Basic validation
        String errorMessage = null;
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            birthday == null || birthday.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            retypePassword == null || retypePassword.trim().isEmpty()) {
            errorMessage = "All fields are required!";
        } else if (!password.equals(retypePassword)) {
            errorMessage = "Passwords do not match!";
        } else if (!Pattern.matches("^\\d{10}$", phone)) {
            errorMessage = "Phone number must be 10 digits!";
        } else if (!Pattern.matches("^[\\w.-]+@[\\w.-]+\\.\\w+$", email)) {
            errorMessage = "Invalid email format!";
        } else if (password.length() < 8) {
            errorMessage = "Password must be at least 8 characters long!";
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("WEB-INF/Pages/SuyoGuruu_Registration_Page.jsp").forward(request, response);
            return;
        }

        try {
            // Check if username or email already exists
            if (teacherDAO.isUsernameExists(username)) {
                errorMessage = "Username already exists!";
            } else if (teacherDAO.isEmailExists(email)) {
                errorMessage = "Email already exists!";
            } else {
                // Hash password
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

                // Create Teacher object
                TeacherModel teacher = new TeacherModel();
                teacher.setFirstName(firstName);
                teacher.setLastName(lastName);
                teacher.setUsername(username);
                teacher.setBirthday(java.sql.Date.valueOf(birthday));
                teacher.setPhone(phone);
                teacher.setEmail(email);
                teacher.setPassword(hashedPassword);

                // Save to database
                teacherDAO.registerTeacher(teacher);
                
                // Store registration success in session
                session.setAttribute("registrationSuccess", true);
                session.setAttribute("registeredUsername", username);
                
                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("WEB-INF/Pages/SuyoGuruu_Registration_Page.jsp").forward(request, response);
                return;
            }
        } catch (SQLException e) {
            errorMessage = "Database error occurred. Please try again.";
            e.printStackTrace();
        }

        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("WEB-INF/Pages/SuyoGuruu_Registration_Page.jsp").forward(request, response);
    }
}