<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/SuyoGuruu_Registration_Page.css">
    <script>
        function togglePassword(inputId) {
            var passwordInput = document.getElementById(inputId);
            var toggleButton = passwordInput.nextElementSibling;
            
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleButton.textContent = "Hide";
            } else {
                passwordInput.type = "password";
                toggleButton.textContent = "Show";
            }
        }
    </script>
</head>
<body>
    <%
        // Session initialization and management
        HttpSession userSession = request.getSession(true);
        
        // Check if user is already logged in
        if (userSession.getAttribute("loggedInUser") != null) {
            // Redirect to dashboard or home page if already logged in
            // response.sendRedirect(request.getContextPath() + "/dashboard");
            // Commented out to avoid actual redirect during implementation
        }
        
        // Set session timeout (30 minutes)
        userSession.setMaxInactiveInterval(30*60);
    %>

    <header>
        <div class="logo">
            <img src="<%= request.getContextPath() %>/Resources/Images/Logo.jpg" alt="Logo" onerror="this.src='<%= request.getContextPath() %>/Resources/Images/default-logo.png'; this.onerror='';">
        </div>
        <nav>
            <a href="#">Sign up</a>
            <a href="<%= request.getContextPath() %>/test-ctl">Sign in</a>
            <div class="menu-icon">
                <div></div>
                <div></div>
                <div></div>
            </div>
        </nav>
    </header>

    <div class="auth-section">
        <div class="container">
            <!-- Left Image -->
            <div class="auth-image">
                <img src="<%= request.getContextPath() %>/Resources/Images/Logo.jpg" alt="Logo" onerror="this.src='<%= request.getContextPath() %>/Resources/Images/default-logo.png'; this.onerror='';">
                <div class="auth-image-gradient"></div>
                <div class="image-overlay">
                    <h3>Welcome to SuyoGuruu</h3>
                    <p>Start your teaching journey today!</p>
                </div>
            </div>

            <!-- Form Container -->
            <div class="auth-container register-container">
                <div class="auth-header">
                    <h2>Registration Form</h2>
                    <p>Register yourself to us.</p>
                </div>

                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    String successMessage = (String) request.getAttribute("successMessage");
                    if(errorMessage != null) {
                %>
                    <div class="error-message">
                        <%= errorMessage %>
                    </div>
                <% 
                    }
                    if(successMessage != null) {
                %>
                    <div class="success-message">
                        <%= successMessage %>
                    </div>
                <% 
                    }
                %>

                <form method="post" action="<%= request.getContextPath() %>/register" class="auth-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label>First Name:</label>
                            <input type="text" name="firstName" value="${param.firstName}" required>
                        </div>
                        <div class="form-group">
                            <label>Last Name:</label>
                            <input type="text" name="lastName" value="${param.lastName}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Username:</label>
                            <input type="text" name="username" value="${param.username}" required>
                        </div>
                        <div class="form-group">
                            <label>Birthday:</label>
                            <input type="date" name="birthday" value="${param.birthday}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Phone Number:</label>
                            <input type="text" name="phone" value="${param.phone}" required>
                        </div>
                        <div class="form-group">
                            <label>Email:</label>
                            <input type="email" name="email" value="${param.email}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group password-field">
                            <label>Password:</label>
                            <input type="password" name="password" id="password" required>
                            <span class="toggle-password" onclick="togglePassword('password')">Show</span>
                        </div>
                        <div class="form-group password-field">
                            <label>Retype Password:</label>
                            <input type="password" name="retypePassword" id="retypePassword" required>
                            <span class="toggle-confirm-password" onclick="togglePassword('retypePassword')">Show</span>
                        </div>
                    </div>

                    <button type="submit" class="auth-button">Submit</button>

                    <div class="auth-footer">
                        <p>Already have an account? <a href="<%= request.getContextPath() %>/test-ctl">Sign in</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 SuyoGuruu</p>
    </footer>
</body>
</html>