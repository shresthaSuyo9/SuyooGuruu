<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.SuyooGuruu.model.TeacherModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Profile.css">
</head>
<body>
    <div class="container">
        <h1>Teacher Profile</h1>

        <!-- Profile Display Section -->
        <div id="profileDisplay" class="profile-display">
            <div class="profile-content">
                <div class="profile-details">
                    <h2 id="displayName">
                        <% 
                            TeacherModel teacher = (TeacherModel) request.getAttribute("teacher");
                            if (teacher != null && teacher.getFirstName() != null && teacher.getLastName() != null) {
                                out.print(teacher.getFirstName() + " " + teacher.getLastName());
                            } else {
                                out.print("Deepak Bajracharya");
                            }
                        %>
                    </h2>
                    <p><strong>ID:</strong> <span id="displayID">${teacher != null && teacher.id != null ? teacher.id : '7'}</span></p>
                    <p><strong>Username:</strong> <span id="displayUsername">${teacher != null && teacher.username != null ? teacher.username : 'SUBRI'}</span></p>
                    <p><strong>Email:</strong> <span id="displayEmail">${teacher != null && teacher.email != null ? teacher.email : 'Subri@example.com'}</span></p>
                    <p><strong>Phone:</strong> <span id="displayPhone">${teacher != null && teacher.phone != null ? teacher.phone : '9857416320'}</span></p>
                    <p><strong>Birthday:</strong> <span id="displayBirthday">${teacher != null && teacher.birthday != null ? teacher.birthday : '02/03/2001'}</span></p>
                </div>
            </div>
            <div class="action-buttons">
                <button type="button" class="btn btn-edit" onclick="toggleEditMode()">Update</button>
            </div>
            <% if (request.getAttribute("message") != null) { %>
                <p style="color: green;"><%= request.getAttribute("message") %></p>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <p style="color: red;"><%= request.getAttribute("error") %></p>
            <% } %>
        </div>

        <!-- Profile Edit Form -->
        <form id="profileForm" action="${pageContext.request.contextPath}/Profile" method="post" style="display: none;" onsubmit="return validateForm()">
            <!-- Teacher Details -->
            <div class="form-group">
                <div class="input-field">
                    <label for="firstName">First Name*</label>
                    <input type="text" id="firstName" name="firstName" value="${teacher != null && teacher.firstName != null ? teacher.firstName : 'Deepak'}" required>
                </div>
                <div class="input-field">
                    <label for="lastName">Last Name*</label>
                    <input type="text" id="lastName" name="lastName" value="${teacher != null && teacher.lastName != null ? teacher.lastName : 'Bajracharya'}" required>
                </div>
            </div>

            <div class="form-group">
                <div class="input-field">
                    <label for="username">Username*</label>
                    <input type="text" id="username" name="username" value="${teacher != null && teacher.username != null ? teacher.username : 'DEEPAK'}" required>
                </div>
                <div class="input-field">
                    <label for="email">Email*</label>
                    <input type="email" id="email" name="email" value="${teacher != null && teacher.email != null ? teacher.email : 'DEePak@gmail.com'}" required>
                </div>
            </div>

            <div class="form-group">
                <div class="input-field">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" value="${teacher != null && teacher.phone != null ? teacher.phone : ''}">
                </div>
                <div class="input-field">
                    <label for="birthday">Birthday</label>
                    <input type="date" id="birthday" name="birthday" value="${teacher != null && teacher.birthday != null ? teacher.birthday : ''}">
                </div>
            </div>

            <!-- Password Update Section -->
            <div class="form-group">
                <div class="input-field">
                    <label for="oldPassword">Old Password (if changing password)</label>
                    <input type="password" id="oldPassword" name="oldPassword">
                </div>
                <div class="input-field">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword">
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-update">Save</button>
                <button type="button" class="btn btn-cancel" onclick="toggleEditMode()">Cancel</button>
            </div>
        </form>
    </div>

    <script>
        function toggleEditMode() {
            const profileDisplay = document.getElementById('profileDisplay');
            const profileForm = document.getElementById('profileForm');
            if (profileDisplay.style.display === 'none') {
                profileDisplay.style.display = 'block';
                profileForm.style.display = 'none';
            } else {
                profileDisplay.style.display = 'none';
                profileForm.style.display = 'block';
            }
        }

        function validateForm() {
            const birthday = document.getElementById('birthday').value;
            const datePattern = /^\d{4}-\d{2}-\d{2}$/;
            if (birthday && !datePattern.test(birthday)) {
                alert('Please enter the birthday in YYYY-MM-DD format.');
                return false;
            }

            const oldPassword = document.getElementById('oldPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            if (oldPassword && !newPassword) {
                alert('Please enter a new password if you provide an old password.');
                return false;
            }
            if (newPassword && !oldPassword) {
                alert('Please enter your old password to set a new password.');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>