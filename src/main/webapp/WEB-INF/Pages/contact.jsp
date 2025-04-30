<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Platform - Contact Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/contact.css">
</head>
<body>
    <header>
        <div class="container">
            <nav>
                <div class="logo">Learning Platform</div>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/Intro">HOME</a></li>
                    <li><a href="${pageContext.request.contextPath}/Courses">COURSES</a></li>
                    <li><a href="${pageContext.request.contextPath}/AboutUs">ABOUT US</a></li>
                    <li><a href="/ContactUs" class="active">CONTACT US</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>Contact Us</h1>
            <p>Get in touch with our team for any inquiries or assistance.</p>
        </div>
    </section>

    <main>
        <div class="container">
            <div class="content">
                <h2>Get In Touch</h2>
                <p>We'd love to hear from you! Fill out the form below, and we'll get back to you as soon as possible.</p>
                
                <%-- You can add form processing logic here --%>
                <% 
                String submitted = request.getParameter("submitted");
                if("true".equals(submitted)) {
                %>
                    <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 20px;">
                        Thank you for your message! We will get back to you shortly.
                    </div>
                <% } %>
                
                <div class="contact-form">
                    <form action="contact.jsp" method="post">
                        <input type="hidden" name="submitted" value="true">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <input type="text" id="subject" name="subject" required>
                        </div>
                        <div class="form-group">
                            <label for="message">Message</label>
                            <textarea id="message" name="message" required></textarea>
                        </div>
                        <button type="submit" class="btn">Send Message</button>
                    </form>
                </div>
                
                <div class="contact-info">
                    <h2>Contact Information</h2>
                    <p><strong>Email:</strong> SuyoGuru8504@gmail.com</p>
                    <p><strong>Phone:</strong> 9865327410 \ 9875462310</p>
                    <p><strong>Address:</strong> Kamal Pokhari, Kathmandu</p>
                    <p><strong>Office Hours:</strong> Sunday to Friday, 8:00 AM - 5:30 PM</p>
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