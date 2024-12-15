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
    <title>Registrasi</title>
</head>
<body>
    <h1>Registrasi</h1>
    <form action="RegisterServlet" method="post">
        Username: <input type="text" name="username"><br>
        Password: <input type="password" name="password"><br>
        Email: <input type="text" name="email"><br>
        User Type: 
        <select name="userType">
            <option value="visitor">Visitor</option>
            <option value="staff">Staff</option>
        </select><br>
        <input type="submit" value="Register">
    </form>
    <br>
    <button onclick="window.location.href='index.jsp'">Kembali ke Beranda</button>
</body>
</html>
