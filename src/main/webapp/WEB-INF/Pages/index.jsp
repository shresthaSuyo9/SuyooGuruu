<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Platform - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>
<body>
    <header>
        <div class="container">
            <nav>
                <div class="logo">Learning Platform</div>
                <ul class="nav-links">
                    <li><a href="/Intro" class="active">HOME</a></li>
                    <li><a href="${pageContext.request.contextPath}/Courses">COURSES</a></li>
                    <li><a href="${pageContext.request.contextPath}/AboutUs">ABOUT US</a></li>
                    <li><a href="${pageContext.request.contextPath}/ContactUs">CONTACT US</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>Welcome to our Learning Platform</h1>
            <p>Discover the best online courses to enhance your skills and advance your career.</p>
            <a href="courses.jsp" class="btn">Browse Courses</a>
        </div>
    </section>

    <main>
        <div class="container">
            <div class="content">
                <h2>Why Choose Our Platform?</h2>
                <p>We offer a wide range of high-quality courses designed by industry experts to help you achieve your goals.</p>
                
                <div class="features">
                    <div class="feature">
                        <h3>Expert Instructors</h3>
                        <p>Learn from professionals with years of experience in their respective fields.</p>
                    </div>
                    <div class="feature">
                        <h3>Flexible Learning</h3>
                        <p>Study at your own pace, anywhere and anytime that suits your schedule.</p>
                    </div>
                    <div class="feature">
                        <h3>Practical Skills</h3>
                        <p>Gain hands-on experience with real-world projects and applications.</p>
                    </div>
                    <div class="feature">
                        <h3>Community Support</h3>
                        <p>Join a supportive community of learners and instructors.</p>
                    </div>
                    <div class="feature">
                        <h3>Career Advancement</h3>
                        <p>Improve your job prospects with industry-recognized certifications.</p>
                    </div>
                    <div class="feature">
                        <h3>Affordable Pricing</h3>
                        <p>Access quality education at competitive prices with frequent discounts.</p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    
</body>
</html>