package com.SuyooGuruu.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.SuyooGuruu.dao.TeacherDAO;
import com.SuyooGuruu.model.TeacherModel;
import com.SuyooGuruu.util.Password; // ✅ UTIL IMPORT ADDED
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

/**
 * Servlet implementation class IndexController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/test-ctl" })
public class IndexController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO teacherDAO;

    /**
     * Initialize the servlet with TeacherDAO
     */
    public void init() {
        teacherDAO = new TeacherDAO();
    }

    public IndexController() {
        super();
    }

    /**
     * Handles GET requests to display the login page
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInTeacher") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        request.getRequestDispatcher("WEB-INF/Pages/Login.jsp").forward(request, response);
    }

    /**
     * Handles POST requests to process login
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");

        String errorMessage = null;

        if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            errorMessage = "Username/Email and password are required!";
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("WEB-INF/Pages/Login.jsp").forward(request, response);
            return;
        }

        TeacherModel teacher = teacherDAO.getTeacherByUsernameOrEmail(usernameOrEmail);

		// ✅ Start of added logic
		if (teacher == null) {
		    errorMessage = "Invalid username or email!";
		} else if (Password.isDefaultTeacher(usernameOrEmail, password)) {
		    // ✅ Hardcoded login logic
		    session.setAttribute("loggedInTeacher", teacher);
		    session.setAttribute("teacherName", teacher.getFirstName() + " " + teacher.getLastName());
		    session.setAttribute("teacherEmail", teacher.getEmail());
		    session.setMaxInactiveInterval(30 * 60);
		    response.sendRedirect(request.getContextPath() + "/dashboard");
		    return;

		} else if (!BCrypt.checkpw(password, teacher.getPassword())) {
		    errorMessage = "Invalid password!";

		    Integer failedAttempts = (Integer) session.getAttribute("failedLoginAttempts");
		    if (failedAttempts == null) {
		        failedAttempts = 1;
		    } else {
		        failedAttempts++;
		    }
		    session.setAttribute("failedLoginAttempts", failedAttempts);

		    if (failedAttempts >= 5) {
		        session.setAttribute("accountLocked", true);
		        session.setAttribute("lockoutTime", System.currentTimeMillis());
		        errorMessage = "Too many failed attempts. Account temporarily locked.";
		    }

		} else {
		    // ✅ Successful login from DB
		    session.removeAttribute("failedLoginAttempts");
		    session.removeAttribute("accountLocked");

		    session.setAttribute("loggedInTeacher", teacher);
		    session.setAttribute("teacherName", teacher.getFirstName() + " " + teacher.getLastName());
		    session.setAttribute("teacherEmail", teacher.getEmail());
		    session.setMaxInactiveInterval(30 * 60);
		    response.sendRedirect(request.getContextPath() + "/dashboard");
		    return;
		}
		// ✅ End of added logic

        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("WEB-INF/Pages/Login.jsp").forward(request, response);
    }
}
