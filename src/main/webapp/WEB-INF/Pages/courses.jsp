<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Platform - Courses</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/courses.css">
</head>
<body>
    <header>
        <div class="container">
            <nav>
                <div class="logo">Learning Platform</div>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/Intro">HOME</a></li>
                    <li><a href="/Courses" class="active">COURSES</a></li>
                    <li><a href="${pageContext.request.contextPath}/AboutUs">ABOUT US</a></li>
                    <li><a href="${pageContext.request.contextPath}/ContactUs">CONTACT US</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>Our Courses</h1>
            <p>Explore our wide range of courses designed to help you learn new skills and advance your career.</p>
        </div>
    </section>

    <main>
        <div class="container">
            <div class="content">
                <h2>Available Courses</h2>
                <p>Browse through our selection of high-quality courses taught by industry experts.</p>
                
                <%-- You can dynamically generate courses from a database in real applications --%>
                <div class="courses">
                    <% 
                    // Example of how you could use Java to dynamically generate courses
                    String[] courseTitles = {"Web Development Fundamentals", "Python Programming", "Data Science Essentials", 
                                         "Digital Marketing", "Graphic Design", "Business Management"};
                    String[] courseDescriptions = {
                        "Learn the basics of HTML, CSS, and JavaScript to build responsive websites.",
                        "Master Python programming language for data science, web development, and automation.",
                        "Explore data analysis, visualization, and machine learning techniques.",
                        "Learn effective strategies for promoting products and services online.",
                        "Develop your creative skills and learn to use industry-standard design tools.",
                        "Learn essential management principles and leadership skills for business success."
                    };
                    
                    for(int i = 0; i < courseTitles.length; i++) {
                    %>
                        <div class="course">
                            <div class="course-img">Course Image</div>
                            
                            <div class="course-content">
                                <h3><%= courseTitles[i] %></h3>
                                <p><%= courseDescriptions[i] %></p>
                                <a href="#" class="btn">Learn More</a>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; <%= new java.util.Date().getYear() + 1900 %> Learning Platform. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>