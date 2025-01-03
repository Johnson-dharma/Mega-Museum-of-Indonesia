<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="classes.JDBC"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    JDBC jdbc = new JDBC();
    String username = (String) session.getAttribute("username");
    String userType = (String) session.getAttribute("userType");
    String email = (String) session.getAttribute("email");
    int id = (int) session.getAttribute("id");
    double megaWallet = 0;
     try {
        String query = "SELECT megaWallet FROM users WHERE id = ?";
        java.sql.Connection con = jdbc.getConnection();
        PreparedStatement stm = con.prepareStatement(query);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            megaWallet = rs.getDouble("megaWallet");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }finally{
        jdbc.disconnect();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega Museum of Indonesia</title>
    <link rel="shortcut icon" href="Gambar/LOGO.png">
    <link rel="stylesheet" href="CSS/profile.css">
    <style>
        footer {
            background-color: #4a4a4a;
            color: white;
            padding: 10px;
            margin-top: 100px;
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="Home.jsp">
            <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
        </a>
        <h1>Mega Museum of Indonesia</h1>
    </div>
    <div class="container">
        <h1>My Profile</h1>
        <div class="service-details">
        <img src="Gambar/profile.png" alt="realm">
        <div class="service-hover-text">
            <h3><%= username %></h3>
            <h4></h4>
            <p>Visitor of Mega Museum of Indonesia</p>
        </div>
        <div class="service-white service-text">
            <p><%= username %></p>
            <a href="TopUp.jsp">Saldo Mega Wallet: Rp. <%= String.format("%,.0f", megaWallet) %></a>
            <br>
            <a href="ListTicket.jsp" class="tiket">View my ticket ➡️</a>
        </div>
        </div>
     </div>
     <footer>
        <div class="footerUp">
            <img src="Gambar/LOGO.png" alt="logo" class="logo-footer">
            <ul>
                <li>Email: megamuseumidn@megamuseum.co.id</li>
                <li>Instagram: @megamuseum</li>
                <li>Telepon : (021) 8888888</li>
            </ul>
        </div>
        <div class="footerDown">
            <p>COPYRIGHT 2024 MEGA MUSEUM IDN, ALL RIGHT RESERVED. TERMS OF USE. PRIVACY STATEMENT</p>
        </div>
    </footer>
</body>
