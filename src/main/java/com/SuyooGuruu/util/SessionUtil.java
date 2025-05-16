package com.SuyooGuruu.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.SuyooGuruu.model.TeacherModel;

public class SessionUtil {

    public static void setTeacherSession(HttpServletRequest request, TeacherModel teacher) {
        HttpSession session = request.getSession(true);
        session.setAttribute("loggedInTeacher", teacher);
        session.setAttribute("teacherName", teacher.getFirstName() + " " + teacher.getLastName());
        session.setAttribute("teacherEmail", teacher.getEmail());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes
    }

    public static void clearSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("loggedInTeacher") != null;
    }
}
