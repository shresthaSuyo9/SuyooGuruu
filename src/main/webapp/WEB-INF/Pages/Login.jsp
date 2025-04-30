<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Session management
    HttpSession userSession = request.getSession(true);
    
    // If user is already logged in, redirect to dashboard
    if (userSession.getAttribute("loggedInTeacher") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    
    // Set session timeout (30 minutes)
    userSession.setMaxInactiveInterval(30*60);
%>
<!DOCTYPE html>
<html>
<head>
<title>SuyoGuruu - Login</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/SuyoGuruu_Login_Page.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

<section class="auth-section">
<div class="container">
<div class="auth-container login-container">
<div class="auth-header">
<h2>Login</h2>
</div>

<% 
    // Display messages from session if available
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
    <div class="error-message">
        <%= errorMessage %>
    </div>
<% 
    }
    
    // Check if there's a registration success message from session
    Boolean registrationSuccess = (Boolean) session.getAttribute("registrationSuccess");
    if (registrationSuccess != null && registrationSuccess) {
        String username = (String) session.getAttribute("registeredUsername");
%>
    <div class="success-message">
        Registration successful! Please login with your credentials.
    </div>
<%
        // Remove the attributes after displaying the message
        session.removeAttribute("registrationSuccess");
        session.removeAttribute("registeredUsername");
    }
%>

<form action="home" method="post" class="auth-form">
<div class="form-group">
<label for="email">Username</label>
<div class="input-with-icon">
<i class="fas fa-user"></i>
<input type="text" id="email" name="email" required placeholder="Type your username">
</div>
</div>

<div class="form-group password-field">
<label for="password">Password</label>
<div class="input-with-icon">
<i class="fas fa-lock"></i>
<input type="password" id="password" name="password" required placeholder="Type your password">
</div>
<div class="forgot-password-link">
<a href="#">Forgot password?</a>
</div>
</div>

<button type="submit" class="auth-button">LOGIN</button>

<div class="auth-divider">
<span>Or Sign Up using</span>
</div>

<div class="social-login">
<div class="social-icons">
<a href="#" class="social-icon facebook"><i class="fab fa-facebook-f"></i></a>
<a href="#" class="social-icon twitter"><i class="fab fa-twitter"></i></a>
<a href="#" class="social-icon google"><i class="fab fa-google"></i></a>
</div>
</div>

<div class="auth-footer">
<p>Or Sign Up Using</p>
<a href="SuyoGuruu_Registration_Page.jsp" class="signup-link">SIGN UP</a>
</div>
</form>
</div>
</div>
</section>

</body>
</html>