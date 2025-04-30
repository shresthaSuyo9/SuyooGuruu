<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Profile.css">
</head>
<body>
    <div class="container">
        <h1>Your Profile</h1>
        <form action="ProfileServlet" method="post" enctype="multipart/form-data">
            <!-- Photo Upload -->
            <div class="photo-section">
                <label for="photo">
                    <img src="placeholder.jpg" alt="Profile Photo" id="photo-preview">
                    <input type="file" id="photo" name="photo" accept="image/*" onchange="previewPhoto(event)">
                </label>
            </div>

            <!-- Profile Details -->
            <div class="form-group">
                <div class="input-field">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="${user.fullName}">
                </div>
                <div class="input-field">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="${user.username}" readonly>
                </div>
            </div>
            <div class="form-group">
                <div class="input-field">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${user.email}">
                </div>
                <div class="input-field">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" value="${user.phone}">
                </div>
            </div>
            <button type="submit" name="action" value="updateProfile" class="btn btn-update">Update Profile</button>

            <!-- Password Update -->
            <div class="form-group">
                <div class="input-field">
                    <label for="oldPassword">Old Password</label>
                    <input type="password" id="oldPassword" name="oldPassword">
                </div>
                <div class="input-field">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword">
                </div>
            </div>
            <button type="submit" name="action" value="updatePassword" class="btn btn-update">Update Password</button>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <button type="button" class="btn btn-cancel" onclick="window.location.href='dashboard.jsp'">Cancel</button>
                <button type="submit" name="action" value="deleteUser" class="btn btn-delete">Delete User</button>
            </div>
        </form>
    </div>

    <script>
        function previewPhoto(event) {
            const reader = new FileReader();
            reader.onload = function() {
                const output = document.getElementById('photo-preview');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>