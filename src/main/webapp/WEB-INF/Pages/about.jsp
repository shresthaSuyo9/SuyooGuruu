<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Platform - About Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/aboutus.css">
</head>
<body>
    <header>
        <div class="container">
            <nav>
                <div class="logo">Learning Platform</div>
                <ul class="nav-links">
                    <li><a href="Intro">HOME</a></li>
                    <li><a href="Courses">COURSES</a></li>
                    <li><a href="AboutUs" class="active">ABOUT US</a></li>
                    <li><a href="ContactUs">CONTACT US</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>About Us</h1>
            <p>Learn more about our mission, vision, and the team behind our learning platform.</p>
        </div>
    </section>

    <main>
        <div class="container">
            <div class="content">
                <h2>Our Story</h2>
                <p>
                    Founded in 2020, Learning Platform was established with a vision to provide accessible, affordable, and high-quality education to learners worldwide. We believe that everyone deserves access to education that can transform their lives and careers.
                </p>

                <h2>Our Mission</h2>
                <p>
                    Our mission is to empower individuals with knowledge and skills that enable them to achieve their personal and professional goals. We strive to create a learning environment that is engaging, supportive, and tailored to the needs of modern learners.
                </p>

                <h2>Our Values</h2>
                <ul>
                    <li>Excellence in education</li>
                    <li>Accessibility and inclusivity</li>
                    <li>Innovation in teaching methods</li>
                    <li>Community and collaboration</li>
                    <li>Lifelong learning</li>
                </ul>

                <h2>Meet Our Team</h2>
                <div class="team">
                    <!-- Team Member 1 -->
                    <div class="team-member">
                        <div class="team-img">
                            <img src="Resources/Images/Suyog.jpg" alt="Suyog Shrestha">
                        </div>
                        <div class="team-content">
                            <h3>Suyog Shrestha</h3>
                            <p>Founder & CEO</p>
                        </div>
                    </div>
                    
                    <!-- Team Member 2 -->
                    <div class="team-member">
                        <div class="team-img">
                            <img src="Resources/Images/Samir.jpg" alt="Samir Adhikari">
                        </div>
                        <div class="team-content">
                            <h3>Samir Adhikari</h3>
                            <p>Chief Learning Officer</p>
                        </div>
                    </div>
                    
                    <!-- Team Member 3 -->
                    <div class="team-member">
                        <div class="team-img">
                            <img src="Resources/Images/Prasiddha.jpg" alt="Prasidha Rawel">
                        </div>
                        <div class="team-content">
                            <h3>Prashiddha Rawel</h3>
                            <p>Head of Content</p>
                        </div>
                    </div>
                    
                    <!-- Team Member 4 -->
                    <div class="team-member">
                        <div class="team-img">
                            <img src="Resources/Images/Suman.jpg" alt="Suman Lama">
                        </div>
                        <div class="team-content">
                            <h3>Suman Lama</h3>
                            <p>Lead Instructor</p>
                        </div>
                    </div>
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