<%-- 
    Document   : Register
    Created on : 11 Dec 2024, 00.03.25
    Author     : raya
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Your Account</title>
    <link rel="stylesheet" href="CSS/Register.css">
</head>
<body>
    <div class="container">
        <h1>Create your account</h1>
        <form action="RegisterServlet" method="post">
            <!-- Username Field -->
            <div class="form-group">
                <input type="text" id="username" name="username" placeholder="Username">
                <label for="username">&#128100;</label>
            </div>
            
            <!-- Email Field -->
            <div class="form-group">
                <input type="email" id="email" name="email" placeholder="Email">
                <label for="email">&#9993;</label>
            </div>
            
            <!-- Password Field -->
            <div class="form-group">
                <input type="password" id="password" name="password" placeholder="Password">
                <label for="password">&#128274;</label>
            </div>
            
            <!-- Sign Up Button -->
            <div class="form-group">
                <input type="hidden" name="userType" value="visitor">
                <button type="submit" class="sign-up">Sign up</button>
            </div>
            
        </form>
        
        <!-- Back Link -->
        <div class="back-btn">
            <span>Already have an account? <a href="Login.jsp">Log in</a></span>
        </div>
    </div>
</body>
</html>
