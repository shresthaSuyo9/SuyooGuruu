<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuyoGuruu - Add Teacher</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/AddTeacher.css">
</head>
<body>
    <header>
        <div class="logo">
            <img src="<%= request.getContextPath() %>/Resources/Images/Logo.jpg" alt="SuyoGuruuLogo">
            <h1>SuyoGuruu Teacher Management System</h1>
        </div>
        <nav>
            <a href="<%= request.getContextPath() %>/dashboard.jsp">Information</a>
            <a href="${pageContext.request.contextPath}/home">Home</a>
        </nav>
    </header>

    <main>
        <div class="page-header">
            <h2>Add New Teacher</h2>
            <p>Enter the details to add a new teacher to the system</p>
        </div>

        <div class="form-container">
            <form action="<%= request.getContextPath() %>/processAddTeacher.jsp" method="post" id="teacherForm">
                <div class="form-section">
                    <h3>Personal Information</h3>
                    <div class="form-group">
                        <label for="teacherName">Teacher Name<span class="required">*</span></label>
                        <input type="text" id="teacherName" name="teacherName" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email<span class="required">*</span></label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="department">Department<span class="required">*</span></label>
                        <select id="department" name="departmentID" required>
                            <option value="">-- Select Department --</option>
                            <!-- Department options will be populated dynamically -->
                            <option value="1">Mathematics</option>
                            <option value="2">Science</option>
                            <option value="3">Languages</option>
                            <option value="4">Social Studies</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-section">
                    <h3>Subject Assignment</h3>
                    <div class="form-group subjects-container">
                        <label>Subjects<span class="required">*</span></label>
                        <div class="subjects-list">
                            <div class="subject-item">
                                <select name="subjectID1" required>
                                    <option value="">-- Select Subject --</option>
                                    <!-- Subject options will be populated dynamically -->
                                    <option value="1">Mathematics</option>
                                    <option value="2">Physics</option>
                                    <option value="3">Chemistry</option>
                                    <option value="4">Biology</option>
                                </select>
                            </div>
                            <!-- Pre-add additional subject fields instead of using JavaScript -->
                            <div class="subject-item">
                                <select name="subjectID2">
                                    <option value="">-- Select Subject (Optional) --</option>
                                    <option value="1">Mathematics</option>
                                    <option value="2">Physics</option>
                                    <option value="3">Chemistry</option>
                                    <option value="4">Biology</option>
                                </select>
                            </div>
                            <div class="subject-item">
                                <select name="subjectID3">
                                    <option value="">-- Select Subject (Optional) --</option>
                                    <option value="1">Mathematics</option>
                                    <option value="2">Physics</option>
                                    <option value="3">Chemistry</option>
                                    <option value="4">Biology</option>
                                </select>
                            </div>
                        </div>
                        <p class="hint-text">Select up to 3 subjects for this teacher</p>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-primary">Save Teacher & Continue to Contract</button>
                    <button type="button" class="btn-outline" onclick="location.href='<%= request.getContextPath() %>/teachers.jsp'">Cancel</button>
                </div>
            </form>
        </div>
    </main>
    
    <footer>
        <p>&copy; 2025 SuyoGuruu Teacher Management System. All rights reserved.</p>
    </footer>
</body>
</html>