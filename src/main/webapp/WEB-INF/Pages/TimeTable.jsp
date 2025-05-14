<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SuyooGuruu - Timetable Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/TimeTable.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>SuyooGuruu Teacher Management System</h1>
            <h2>Timetable Management</h2>
        </header>
        
        <div class="content">
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <div class="timetable-controls">
                <form action="TimeTable" method="get" class="filter-form">
                    <div class="form-group">
                        <label for="teacherFilter">Filter by Teacher:</label>
                        <select id="teacherFilter" name="teacherId">
                            <option value="">All Teachers</option>
                            <c:forEach var="teacher" items="${teachers}">
                                <option value="${teacher.id}" ${teacher.id == selectedTeacherId ? 'selected' : ''}>
                                    ${teacher.firstName} ${teacher.lastName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="dayFilter">Filter by Day:</label>
                        <select id="dayFilter" name="day">
                            <option value="">All Days</option>
                            <c:forEach var="day" items="${['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']}">
                                <option value="${day}" ${day == selectedDay ? 'selected' : ''}>${day}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Apply Filter</button>
                    <a href="TimeTable" class="btn btn-secondary">Clear Filter</a>
                </form>
                
                <button class="btn btn-success" onclick="showAddTimetableForm()">Add New Timetable Entry</button>
            </div>
            
            <!-- Add/Edit Timetable Form (Hidden by default) -->
            <div id="timetableForm" class="form-popup" style="display: none;">
                <form action="TimeTable" method="post" class="form-container">
                    <h3 id="formTitle">Add Timetable Entry</h3>
                    
                    <input type="hidden" id="timetableId" name="timetableId" value="">
                    
                    <div class="form-group">
                        <label for="teacherId"><b>Teacher</b></label>
                        <select id="teacherId" name="teacherId" required>
                            <option value="">Select Teacher</option>
                            <c:forEach var="teacher" items="${teachers}">
                                <option value="${teacher.id}">${teacher.firstName} ${teacher.lastName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="day"><b>Day</b></label>
                        <select id="day" name="day" required>
                            <option value="">Select Day</option>
                            <c:forEach var="day" items="${['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']}">
                                <option value="${day}">${day}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="startTime"><b>Start Time</b></label>
                        <input type="time" id="startTime" name="startTime" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="endTime"><b>End Time</b></label>
                        <input type="time" id="endTime" name="endTime" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="subject"><b>Subject</b></label>
                        <input type="text" id="subject" name="subject" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="room"><b>Room</b></label>
                        <input type="text" id="room" name="room" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button type="button" class="btn btn-danger" onclick="closeForm()">Cancel</button>
                    </div>
                </form>
            </div>
            
            <!-- Timetable Display -->
            <div class="timetable-container">
                <table class="timetable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Teacher</th>
                            <th>Day</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Subject</th>
                            <th>Room</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="timetable" items="${timetables}">
                            <tr>
                                <td>${timetable.id}</td>
                                <td>${timetable.teacherName}</td>
                                <td>${timetable.day}</td>
                                <td>${timetable.startTime}</td>
                                <td>${timetable.endTime}</td>
                                <td>${timetable.subject}</td>
                                <td>${timetable.room}</td>
                                <td class="actions">
                                    <button class="btn-edit" onclick="editTimetable('${timetable.id}', 
                                                                                  '${timetable.teacherId}',
                                                                                  '${timetable.day}',
                                                                                  '${timetable.startTime}',
                                                                                  '${timetable.endTime}',
                                                                                  '${timetable.subject}',
                                                                                  '${timetable.room}')">Edit</button>
                                    <button class="btn-delete" onclick="confirmDelete('${timetable.id}')">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <footer>
            <p>© 2025 SuyooGuruu Teacher Management System</p>
        </footer>
    </div>
    
    <script>
        function showAddTimetableForm() {
            document.getElementById("formTitle").innerText = "Add Timetable Entry";
            document.getElementById("timetableId").value = "";
            document.getElementById("teacherId").value = "";
            document.getElementById("day").value = "";
            document.getElementById("startTime").value = "";
            document.getElementById("endTime").value = "";
            document.getElementById("subject").value = "";
            document.getElementById("room").value = "";
            document.getElementById("timetableForm").style.display = "block";
        }
        
        function editTimetable(id, teacherId, day, startTime, endTime, subject, room) {
            document.getElementById("formTitle").innerText = "Edit Timetable Entry";
            document.getElementById("timetableId").value = id;
            document.getElementById("teacherId").value = teacherId;
            document.getElementById("day").value = day;
            document.getElementById("startTime").value = startTime;
            document.getElementById("endTime").value = endTime;
            document.getElementById("subject").value = subject;
            document.getElementById("room").value = room;
            document.getElementById("timetableForm").style.display = "block";
        }
        
        function closeForm() {
            document.getElementById("timetableForm").style.display = "none";
        }
        
        function confirmDelete(id) {
            if (confirm("Are you sure you want to delete this timetable entry?")) {
                window.location.href = "DeleteTimetable?id=" + id;
            }
        }
    </script>
</body>
</html>