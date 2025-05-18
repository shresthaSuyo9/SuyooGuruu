package com.SuyooGuruu.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.SuyooGuruu.model.TeacherModel;
import com.SuyooGuruu.dao.TeacherDAO;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/teachers", "/teachers/add", "/teachers/edit", "/teachers/delete", "/teachers/search"})
public class AddTeacher extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        teacherDAO = new TeacherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/teachers":
                listTeachers(request, response);
                break;
            case "/teachers/add":
                showAddForm(request, response);
                break;
            case "/teachers/edit":
                showEditForm(request, response);
                break;
            case "/teachers/delete":
                deleteTeacher(request, response);
                break;
            case "/teachers/search":
                searchTeachers(request, response);
                break;
            default:
                listTeachers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/teachers/add":
                addTeacher(request, response);
                break;
            case "/teachers/edit":
                updateTeacher(request, response);
                break;
            default:
                listTeachers(request, response);
                break;
        }
    }

    private void listTeachers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<TeacherModel> teachers = teacherDAO.getAllTeachers();
        request.setAttribute("searchResults", teachers);
        request.getRequestDispatcher("/WEB-INF/Pages/AddTeacher.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/addTeacherForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        TeacherModel teacher = teacherDAO.getTeacherById(id);
        request.setAttribute("teacher", teacher);
        request.getRequestDispatcher("/WEB-INF/Pages/editTeacher.jsp").forward(request, response);
    }

    private void addTeacher(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        TeacherModel teacher = new TeacherModel();
        teacher.setFirstName(request.getParameter("firstName"));
        teacher.setLastName(request.getParameter("lastName"));
        teacher.setUsername(request.getParameter("username"));
        teacher.setEmail(request.getParameter("email"));
        teacher.setPhone(request.getParameter("phone"));
        teacher.setPassword(request.getParameter("password"));
        String birthdayStr = request.getParameter("birthday");
        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            teacher.setBirthday(Date.valueOf(birthdayStr));
        }

        teacherDAO.addTeacher(teacher);
        response.sendRedirect(request.getContextPath() + "/teachers");
    }

    private void updateTeacher(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        TeacherModel teacher = new TeacherModel();
        teacher.setId(Long.parseLong(request.getParameter("id")));
        teacher.setFirstName(request.getParameter("firstName"));
        teacher.setLastName(request.getParameter("lastName"));
        teacher.setUsername(request.getParameter("username"));
        teacher.setEmail(request.getParameter("email"));
        teacher.setPhone(request.getParameter("phone"));
        teacher.setPassword(request.getParameter("password"));
        String birthdayStr = request.getParameter("birthday");
        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            teacher.setBirthday(Date.valueOf(birthdayStr));
        }

        teacherDAO.updateTeacher(teacher);
        response.sendRedirect(request.getContextPath() + "/teachers");
    }

    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        teacherDAO.deleteTeacher(id);
        response.sendRedirect(request.getContextPath() + "/teachers");
    }

    private void searchTeachers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        List<TeacherModel> teachers = teacherDAO.searchTeachersByName(searchName);
        request.setAttribute("searchResults", teachers);
        request.getRequestDispatcher("/WEB-INF/Pages/AddTeacher.jsp").forward(request, response);
    }
}