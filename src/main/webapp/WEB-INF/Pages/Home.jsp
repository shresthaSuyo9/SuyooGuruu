<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Button styles */
        .action-button {
            padding: 12px 25px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin: 10px 5px;
        }
        
        .action-button:hover {
            background-color: #2980b9;
        }
        
        /* Modal styles */
        .input-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }
        
        .input-modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 50%;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            animation: modalFadeIn 0.3s;
        }
        
        @keyframes modalFadeIn {
            from {opacity: 0; transform: translateY(-20px);}
            to {opacity: 1; transform: translateY(0);}
        }
        
        .input-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .close-modal {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .close-modal:hover {
            color: #333;
        }
        
        .input-form {
            display: flex;
            flex-direction: column;
        }
        
        .form-row {
            margin-bottom: 15px;
        }
        
        .form-row label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        .form-row input, .form-row textarea, .form-row select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-row textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        
        .submit-btn {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .submit-btn:hover {
            background-color: #219653;
        }
        
        .cancel-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .cancel-btn:hover {
            background-color: #c0392b;
        }
        
        /* Button container */
        .action-buttons-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin: 30px 0;
        }
        
        /* Added styles for better appearance */
        .hero {
            background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('/api/placeholder/1200/600');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 20px;
            text-align: center;
        }
        
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        
        .hero p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto 20px;
        }
        
        .features {
            padding: 60px 20px;
            background-color: #f9f9f9;
        }
        
        .features h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #333;
            font-weight: 600;
        }
        
        .feature-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .feature-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 25px;
            width: 300px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .feature-card .icon {
            font-size: 3rem;
            color: #3498db;
            margin-bottom: 15px;
        }
        
        .system-benefits {
            padding: 60px 20px;
        }
        
        .system-benefits h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #333;
            font-weight: 600;
        }
        
        .benefit-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .benefit-card {
            display: flex;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 500px;
            transition: transform 0.3s;
        }
        
        .benefit-card:hover {
            transform: translateY(-5px);
        }
        
        .benefit-image {
            background-color: #3498db;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
            font-size: 2.5rem;
        }
        
        .benefit-content {
            padding: 25px;
        }
        
        .benefit-content h3 {
            margin-top: 0;
            color: #333;
        }
        
        .more-link {
            display: inline-block;
            margin-top: 15px;
            color: #3498db;
            font-weight: bold;
            text-decoration: none;
        }
        
        .more-link:hover {
            text-decoration: underline;
        }
        
        /* Enhanced footer styles */
        footer {
            background-color: #333;
            color: white;
            padding: 40px 20px 20px;
        }
        
        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-column {
            width: 23%;
            min-width: 200px;
            margin-bottom: 30px;
        }
        
        .footer-column h4 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 1.2rem;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
            display: inline-block;
        }
        
        .footer-column ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .footer-column li {
            margin-bottom: 10px;
        }
        
        .footer-column a {
            color: #ddd;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .footer-column a:hover {
            color: #3498db;
        }
        
        .social-icons {
            display: flex;
            gap: 15px;
        }
        
        .social-icons a {
            background-color: #444;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s;
        }
        
        .social-icons a:hover {
            background-color: #3498db;
        }
        
        .copyright {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #444;
        }
    </style>
</head>
<body>
    <div class="announcement-bar">
        <p>Welcome to the Teacher Management System - Streamlining education administration</p>
    </div>

    <header>
        <div class="header-container">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/home"><i class="fas fa-chalkboard-teacher"></i> TeacherMS</a>
            </div>
            <nav>
                <ul class="main-menu">
                    <li><a href="${pageContext.request.contextPath}/Intro">HOME</a></li>
                    <li><a href="${pageContext.request.contextPath}/Courses">COURSES</a></li>
                    <li><a href="${pageContext.request.contextPath}/Aboutus">ABOUT US</a></li>
                    <li><a href="${pageContext.request.contextPath}/ContactUs">CONTACT US</a></li>
                </ul>
            </nav>
            <div class="user-actions">
                <a href="#" class="search-icon"><i class="fas fa-search"></i></a>
                <a href="${pageContext.request.contextPath}/profile" class="account-icon"><i class="fas fa-user"></i></a>
                <a href="${pageContext.request.contextPath}/notifications" class="notification-icon"><i class="fas fa-bell"></i></a>
             
            </div>
        </div>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h1>SuyoGuruu Teacher Management System</h1>
            <p>A comprehensive solution for managing teachers, departments, courses, for educational institutions.</p>
            <div class="subtext">
                <p>Streamline your educational institution's administrative tasks with our powerful yet intuitive management system.</p>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons-container">
                <a href="${pageContext.request.contextPath}/AddTeacher" class="action-button"><i class="fas fa-user-plus"></i> Add Teacher</a>
            </div>
        </div>
    </section>

    <section class="features">
        <h2>SYSTEM MODULES</h2>
        <div class="feature-grid">
            <div class="feature-card">
                <i class="fas fa-user-tie icon"></i>
                <h3>Teacher Management</h3>
                <p>Manage teacher profiles, qualifications, and performance metrics</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-building icon"></i>
                <h3>Department Management</h3>
                <p>Organize departments, assign heads, and track resources</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-book icon"></i>
                <h3>Course Management</h3>
                <p>Create and assign courses, track curriculum, and manage materials</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-calendar-alt icon"></i>
                <h3>Schedule Planning</h3>
                <p>Efficiently manage timetables, classes, and room assignments</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-chart-line icon"></i>
                <h3>Reports and Analytics</h3>
                <p>Generate insights with comprehensive reporting tools</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-cogs icon"></i>
                <h3>System Administration</h3>
                <p>Manage users, permissions, and system configurations</p>
            </div>
        </div>
    </section>

    <section class="system-benefits">
        <h2>KEY BENEFITS</h2>
        <div class="benefit-cards">
            <div class="benefit-card">
                <div class="benefit-image">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="benefit-content">
                    <h3>Time-Saving Automation</h3>
                    <p>Automate routine administrative tasks including scheduling, reporting, and notifications to save valuable time for staff and faculty</p>
                    <a href="${pageContext.request.contextPath}/features" class="more-link">Learn More</a>
                </div>
            </div>
            <div class="benefit-card">
                <div class="benefit-image">
                    <i class="fas fa-chart-pie"></i>
                </div>
                <div class="benefit-content">
                    <h3>Data-Driven Decisions</h3>
                    <p>Access comprehensive analytics and reporting tools to make informed decisions about resource allocation and institutional planning</p>
                    <a href="${pageContext.request.contextPath}/analytics" class="more-link">Learn More</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Form Pages for Add Teacher, Add Department, Add Course, Create Schedule -->
    <!-- These are separate pages linked by the action buttons above -->

    <footer>
        <div class="footer-container">
            <div class="footer-column">
                <h4>Teacher Management System</h4>
                <p>Streamlining education administration for institutions of all sizes.</p>
            </div>
            <div class="footer-column">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/Intro">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/Courses">Courses</a></li>
                    <li><a href="${pageContext.request.contextPath}/AboutUs">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/Contactus">Contact Us</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Contact Us</h4>
                <p>Email: SuyoGuru@gmail.com</p>
                <p>Phone: 9865327410 / 9876523410</p>
            </div>
            <div class="footer-column">
                <h4>Follow Us</h4>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2025 Teacher Management System. All rights reserved.</p>
        </div>
    </footer>

    <!-- Login Modal -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Login</h2>
            <form action="${pageContext.request.contextPath}/home" method="post">
                <input type="hidden" name="action" value="login">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="submit-button">Login</button>
            </form>
            <div class="form-footer">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register</a></p>
            </div>
        </div>
    </div>
</body>
</html>