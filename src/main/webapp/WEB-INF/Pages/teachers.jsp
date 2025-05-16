<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuyoGuruu - Teachers List</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/AddTeacher.css">
    <style>
        .table-container {
            max-width: 1200px;
            margin: 20px auto;
        }
        .teacher-table {
            width: 100%;
            border-collapse: collapse;
        }
        .teacher-table th, .teacher-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .teacher-table th {
            background-color: #f2f2f2;
        }
        .action-links a {
            margin-right: 10px;
            text-decoration: none;
            color: #0066cc;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .add-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #0066cc;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="<%= request.getContextPath() %>/Resources/Images/Logo.jpg" alt="SuyoGuruuLogo">
            <h1>SuyoGuruu Teacher Management System</h1>
        </div>
        <nav>
            <a href="<%= request.getContextPath() %>/dashboard.jsp">Information</a>
            <a href="${pageContext.request.contextPath}/timetable.jsp">Schedule Management</a>
            <a href="${pageContext.request.contextPath}/home">Home</a>
        </nav>
    </header>

    <main>
        <div class="page-header">
            <h2>Teachers List</h2>
            <p>Manage all teachers in the system</p>
        </div>

        <div class="table-container">
            <a href="<%= request.getContextPath() %>/teachers/add" class="add-btn">Add New Teacher</a>
            <table class="teacher-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Birthday</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="teacher" items="${teachers}">
                        <tr>
                            <td>${teacher.id}</td>
                            <td>${teacher.firstName}</td>
                            <td>${teacher.lastName}</td>
                            <td>${teacher.username}</td>
                            <td>${teacher.email}</td>
                            <td>${teacher.phone}</td>
                            <td>${teacher.birthday}</td>
                            <td class="action-links">
                                <a href="<%= request.getContextPath() %>/teachers/edit?id=${teacher.id}">Edit</a>
                                <a href="<%= request.getContextPath() %>/teachers/delete?id=${teacher.id}" 
                                   onclick="return confirm('Are you sure you want to delete this teacher?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <footer>
        <p>© 2025 SuyoGuruu Teacher Management System. All rights reserved.</p>
    </footer>
</body>
</html>