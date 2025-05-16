package com.SuyooGuruu.util;

public class Password {
    public static boolean isDefaultTeacher(String usernameOrEmail, String password) {
        return ("suyog".equalsIgnoreCase(usernameOrEmail) || "suyog@gmail.com".equalsIgnoreCase(usernameOrEmail))
                && "suyog123".equals(password);
    }
}
