<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuyoGuruu - Edit Teacher</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/AddTeacher.css">
    <style>
        .dashboard-container {
            display: flex;
            gap:  dins20px;
            max-width: 1200px;
            margin: 0 auto;
        }
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
        </nav>
    </header>

    <main>
        <div class="page-header">
            <h2>Edit Teacher</h2>
            <p>Update the teacher's details</p>
        </div>

        <div class="dashboard-container">
            <div class="form-container">
                <form action="<%= request.getContextPath() %>/teachers/edit" method="post">
                    <input type="hidden" name="id" value="${teacher.id}">
                    <div class="form-group">
                        <label for="firstName">First Name<span class="required">*</span></label>
                        <input type="text" id="firstName" name="firstName" value="${teacher.firstName}" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name<span class="required">*</span></label>
                        <input type="text" id="lastName" name="lastName" value="${teacher.lastName}" required>
                    </div>
                    <div class="form-group">
                        <label for="username">Username<span class="required">*</span></label>
                        <input type="text" id="username" name="username" value="${teacher.username}" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email<span class="required">*</span></label>
                        <input type="email" id="email" name="email" value="${teacher.email}" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" value="${teacher.phone}">
                    </div>
                    <div class="form-group">
                        <label for="birthday">Birthday</label>
                        <input type="date" id="birthday" name="birthday" value="${teacher.birthday}">
                    </div>
                    <div class="form-group">
                        <label for="password">Password<span class="required">*</span></label>
                        <input type="password" id="password" name="password" value="${teacher.password}" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">Update Teacher</button>
                        <button type="button" class="btn-outline" 
                                onclick="location.href='<%= request.getContextPath() %>/teachers'">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <footer>
        <p>© 2025 SuyoGuruu Teacher Management System. All rights reserved.</p>
    </footer>
</body>
</html>