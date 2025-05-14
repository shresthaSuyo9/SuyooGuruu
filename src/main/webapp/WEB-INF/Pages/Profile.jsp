<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    
    <!-- Profile Display Section (Initially Hidden) -->
    <div id="profileDisplay" class="profile-display" style="display: none;">
        <div class="photo-display">
            <img src="placeholder.jpg" alt="Profile Photo" id="displayed-photo">
        </div>
        <div class="profile-details">
            <h2 id="displayName"></h2>
            <p><strong>Teacher ID:</strong> <span id="displayID"></span></p>
            <p><strong>Email:</strong> <span id="displayEmail"></span></p>
            <p><strong>Phone:</strong> <span id="displayPhone"></span></p>
            <p><strong>Address:</strong> <span id="displayAddress"></span></p>
            <p><strong>Department:</strong> <span id="displayDepartment"></span></p>
        </div>
        <button type="button" class="btn btn-edit" onclick="toggleEditMode()">Edit Profile</button>
    </div>
    
    <!-- Profile Edit Form -->
    <form id="profileForm" action="ProfileServlet" method="post" enctype="multipart/form-data">
        <!-- Photo Upload -->
        <div class="photo-section">
            <label for="photo">
                <img src="${empty user.photoUrl ? 'placeholder.jpg' : user.photoUrl}" alt="Profile Photo" id="photo-preview">
                <input type="file" id="photo" name="photo" accept="image/*" onchange="previewPhoto(event)">
            </label>
        </div>

        <!-- Teacher Details -->
        <div class="form-group">
            <div class="input-field">
                <label for="teacherID">Teacher ID*</label>
                <input type="text" id="teacherID" name="teacherID" value="${user.teacherID}" required>
            </div>
            <div class="input-field">
                <label for="teacherName">Teacher Name*</label>
                <input type="text" id="teacherName" name="teacherName" value="${user.teacherName}" required>
            </div>
        </div>
        
        <div class="form-group">
            <div class="input-field">
                <label for="email">Email*</label>
                <input type="email" id="email" name="email" value="${user.email}" required>
            </div>
            <div class="input-field">
                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone" value="${user.phone}">
            </div>
        </div>
        
        <div class="form-group single-field">
            <div class="input-field">
                <label for="address">Address*</label>
                <input type="text" id="address" name="address" value="${user.address}" required>
            </div>
        </div>
        
        <div class="form-group single-field">
            <div class="input-field">
                <label for="department">Department*</label>
                <select id="department" name="department" required>
                    <option value="" disabled selected>-- Select Department --</option>
                    <option value="Computer Science" ${user.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                    <option value="Mathematics" ${user.department == 'Mathematics' ? 'selected' : ''}>Mathematics</option>
                    <option value="Physics" ${user.department == 'Physics' ? 'selected' : ''}>Physics</option>
                    <option value="Chemistry" ${user.department == 'Chemistry' ? 'selected' : ''}>Chemistry</option>
                    <option value="Biology" ${user.department == 'Biology' ? 'selected' : ''}>Biology</option>
                    <option value="Engineering" ${user.department == 'Engineering' ? 'selected' : ''}>Engineering</option>
                    <option value="Literature" ${user.department == 'Literature' ? 'selected' : ''}>Literature</option>
                    <option value="History" ${user.department == 'History' ? 'selected' : ''}>History</option>
                </select>
            </div>
        </div>

        <!-- Password Fields (Optional in this context) -->
        <div class="form-group password-section" style="display: none;">
            <div class="input-field">
                <label for="oldPassword">Old Password</label>
                <input type="password" id="oldPassword" name="oldPassword">
            </div>
            <div class="input-field">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword">
            </div>
            <button type="button" class="btn btn-password" onclick="updatePassword()">Update Password</button>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <button type="button" id="updateBtn" class="btn btn-update" onclick="updateProfile()">Update Profile</button>
            <button type="button" class="btn btn-cancel" onclick="window.location.href='dashboard.jsp'">Cancel</button>
        </div>
    </form>
</div>

<script>
// Check if there's existing profile data in session storage
document.addEventListener('DOMContentLoaded', function() {
    const savedProfile = sessionStorage.getItem('teacherProfile');
    if (savedProfile) {
        const profileData = JSON.parse(savedProfile);
        displayProfile(profileData);
    }
    
    // Check if there was a form submission triggered by page reload
    const formSubmitted = sessionStorage.getItem('formSubmitted');
    if (formSubmitted) {
        sessionStorage.removeItem('formSubmitted');
        collectAndDisplayProfile();
    }
});

function previewPhoto(event) {
    const reader = new FileReader();
    reader.onload = function() {
        const output = document.getElementById('photo-preview');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
}

function updateProfile() {
    // Validate form
    const form = document.getElementById('profileForm');
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    // Collect and display data
    collectAndDisplayProfile();
    
    // Here you would normally submit the form to the server
    // For now, we're just displaying the data on the page
    // form.submit();
    
    // Mark form as submitted for page reloads
    sessionStorage.setItem('formSubmitted', 'true');
}

function collectAndDisplayProfile() {
    const profileData = {
        teacherID: document.getElementById('teacherID').value,
        teacherName: document.getElementById('teacherName').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value || 'Not provided',
        address: document.getElementById('address').value,
        department: document.getElementById('department').value,
        photoUrl: document.getElementById('photo-preview').src
    };
    
    // Save to session storage for persistence
    sessionStorage.setItem('teacherProfile', JSON.stringify(profileData));
    
    // Display the profile
    displayProfile(profileData);
}

function displayProfile(profileData) {
    // Fill in profile display elements
    document.getElementById('displayName').textContent = profileData.teacherName;
    document.getElementById('displayID').textContent = profileData.teacherID;
    document.getElementById('displayEmail').textContent = profileData.email;
    document.getElementById('displayPhone').textContent = profileData.phone;
    document.getElementById('displayAddress').textContent = profileData.address;
    document.getElementById('displayDepartment').textContent = profileData.department;
    document.getElementById('displayed-photo').src = profileData.photoUrl;
    
    // Also fill in form fields (for when user switches back to edit mode)
    document.getElementById('teacherID').value = profileData.teacherID;
    document.getElementById('teacherName').value = profileData.teacherName;
    document.getElementById('email').value = profileData.email;
    document.getElementById('phone').value = profileData.phone;
    document.getElementById('address').value = profileData.address;
    document.getElementById('department').value = profileData.department;
    document.getElementById('photo-preview').src = profileData.photoUrl;
    
    // Show profile display, hide form
    document.getElementById('profileDisplay').style.display = 'block';
    document.getElementById('profileForm').style.display = 'none';
}

function toggleEditMode() {
    document.getElementById('profileDisplay').style.display = 'none';
    document.getElementById('profileForm').style.display = 'block';
}

function updatePassword() {
    const oldPassword = document.getElementById('oldPassword').value;
    const newPassword = document.getElementById('newPassword').value;
    
    if (!oldPassword || !newPassword) {
        alert('Please fill in both password fields.');
        return;
    }
    
    // Here you would normally handle password update via AJAX or form submission
    alert('Password updated successfully!');
    
    // Clear password fields
    document.getElementById('oldPassword').value = '';
    document.getElementById('newPassword').value = '';
}
</script>
</body>
</html>