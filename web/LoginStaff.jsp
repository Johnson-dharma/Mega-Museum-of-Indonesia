<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="CSS/Login.css">
</head>
<body>
    <div class="login-container">
        <form action="LoginServlet" class="form-login" method="post">
            <ul class="login-nav">
                <li class="login-nav__item active">
                    <a href="Login.jsp">Sign In</a>
                </li>
                <li class="login-nav__item">
                    <a href="Register.jsp">Sign Up</a>
                </li>
                <li class="login-nav__item">
                    <a href="LoginStaff.jsp">Staff</a>
                </li>
            </ul>
            <label for="login-input-user" class="login__label">
                Username
            </label>
            <input id="login-input-user" class="login__input" type="text" name="username"/>
            <label for="login-input-password" class="login__label">
                Password
            </label>
            <input id="login-input-password" class="login__input" type="password" name="password"/>
            <input type="hidden" name="userType" value="staff">
            <input type="submit" class="login__submit" value="Login">
            
        </form>
        <a href="index.jsp" class="login__forgot" >Kembali ke beranda</a>
    </div>

</body>
</html>
