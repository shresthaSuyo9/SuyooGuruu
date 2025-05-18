<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.SuyooGuruu.model.TeacherModel" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuyoGuruu - Manage Teachers</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/AddTeacher.css">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .add-teacher-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            margin-bottom: 20px;
            cursor: pointer;
        }
        .teacher-table-container {
            width: 100%;
        }
        .teacher-table-container table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .teacher-table-container th, .teacher-table-container td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .teacher-table-container th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        .search-container {
            padding: 10px;
            background-color: #f4f4f4;
            border-bottom: 1px solid #ddd;
        }
        .search-container input[type="text"] {
            width: 200px;
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-left: 10px;
        }
        .action-links a {
            color: #0066cc;
            text-decoration: none;
            margin-right: 10px;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        /* Original Form Styles */
        .form-container {
            flex: 1;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-actions {
            margin-top: 20px;
        }
        .btn-primary {
            padding: 10px 20px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-outline {
            padding: 10px 20px;
            background-color: transparent;
            border: 1px solid #0066cc;
            color: #0066cc;
            border-radius: 4px;
            cursor: pointer;
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
            <a href="${pageContext.request.contextPath}/LogOut" class="logout-icon"><i class="fas fa-sign-out-alt"></i></a>
        </nav>
    </header>

    <main>
        <% 
            String showForm = request.getParameter("showForm");
            if ("true".equals(showForm)) { 
        %>
        <!-- Original Add Teacher Form UI -->
        <div class="page-header">
            <h2>Add Teacher</h2>
            <p>Enter the details to add a new teacher to the system</p>
        </div>

        <div class="dashboard-container">
            <div class="form-container">
                <form action="<%= request.getContextPath() %>/teachers/add" method="post">
                    <div class="form-group">
                        <label for="firstName">First Name<span class="required">*</span></label>
                        <input type="text" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name<span class="required">*</span></label>
                        <input type="text" id="lastName" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label for="username">Username<span class="required">*</span></label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email<span class="required">*</span></label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone">
                    </div>
                    <div class="form-group">
                        <label for="birthday">Birthday</label>
                        <input type="date" id="birthday" name="birthday">
                    </div>
                    <div class="form-group">
                        <label for="password">Password<span class="required">*</span></label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">Save Teacher</button>
                        <button type="button" class="btn-outline" 
                                onclick="location.href='<%= request.getContextPath() %>/teachers'">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <% 
            } else { 
        %>
        <!-- Teacher List View with Search -->
        <div class="page-header">
            <h2>Manage Teachers</h2>
            <p>Manage all teachers in the system</p>
        </div>

        <div class="dashboard-container">
            <!-- Add New Teacher Button -->
            <a href="<%= request.getContextPath() %>/teachers?showForm=true" class="add-teacher-btn">Add New Teacher</a>

            <!-- Teacher Table with Search Bar -->
            <div class="teacher-table-container">
                <!-- Search Bar -->
                <div class="search-container">
                    <form action="<%= request.getContextPath() %>/teachers/search" method="get">
                        <input type="text" name="searchName" placeholder="Search..." required>
                    </form>
                </div>

                <!-- Teacher Table -->
                <table>
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
                        <% 
                            List<TeacherModel> teachers = (List<TeacherModel>) request.getAttribute("searchResults");
                            if (teachers != null && !teachers.isEmpty()) {
                                for (TeacherModel teacher : teachers) {
                        %>
                        <tr>
                            <td><%= teacher.getId() %></td>
                            <td><%= teacher.getFirstName() %></td>
                            <td><%= teacher.getLastName() %></td>
                            <td><%= teacher.getUsername() %></td>
                            <td><%= teacher.getEmail() %></td>
                            <td><%= teacher.getPhone() != null ? teacher.getPhone() : "" %></td>
                            <td><%= teacher.getBirthday() != null ? teacher.getBirthday() : "" %></td>
                            <td class="action-links">
                                <a href="<%= request.getContextPath() %>/teachers/edit?id=<%= teacher.getId() %>">Edit</a>
                                <a href="<%= request.getContextPath() %>/teachers/delete?id=<%= teacher.getId() %>">Delete</a>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8">No teachers found.</td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <% 
            } 
        %>
    </main>

    <footer>
        <p>© 2025 SuyoGuruu Teacher Management System. All rights reserved.</p>
    </footer>
</body>
</html>