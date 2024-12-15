<%-- 
    Document   : Login
    Created on : 10 Dec 2024, 21.01.03
    Author     : raya
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/add3d2a7df.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./assets/css/style.css">
</head>
<body>
    <h1>Login</h1>
    <form action="LoginServlet" method="post">
        Username: <input type="text" name="username"><br>
        Password: <input type="password" name="password"><br>
        User Type: 
        <select name="userType">
            <option value="visitor">Visitor</option>
            <option value="staff">Staff</option>
        </select><br>
        <input type="submit" value="Login">
    </form>
    <br>
    
    
    <button onclick="window.location.href='index.jsp'">Kembali ke Beranda</button>
</body>
</html>

