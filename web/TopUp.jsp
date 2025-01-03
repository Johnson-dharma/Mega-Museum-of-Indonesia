<!DOCTYPE html>
<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="classes.JDBC"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Connection con = null;
    Statement stm = null;
    ResultSet rs = null; 
    JDBC jdbc = new JDBC(); 
    String userType = (String) session.getAttribute("userType"); 
%>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Halaman Top Up</title>
    <link rel="shortcut icon" href="Gambar/LOGO.png">
    <link rel="stylesheet" href="CSS/TopUp.css">
    <style>
        body{
            background-image: url('Gambar/topup.jpg');
        }
        @font-face {
            font-family: 'Jacques Francois';
            src: url('JacquesFrancois-Regular.ttf') format('truetype'); /* Ganti dengan path yang sesuai */
        }

        body {
            font-family: 'Jacques Francois', serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }
        
        .header{
            width: 100%;
            height: 100px;
            background-color: black;
            position: fixed;
            top: 0;
            left: 0;
            opacity: 100%;
        }
        .Logo{
            position: absolute;
            top: 50%;
            left: 3%;
            transform: translate(-50%, -50%); /* Memindahkan setengah dari lebar dan tinggi elemen */
            width: 4%;
            border-radius: 50%;
        }
        
        .container {
            max-width: 600px;
            margin: 30px auto;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-radius: 5px;
            padding: 20px;
            margin-top: 10%;
            background-color: #f3f1f1;
        }
        h2 {
            margin-top: 0;
            text-align: center;
            color: #4a4a4a;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="number"], input[type="file"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #4a4a4a;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        button:hover {
            background-color: #666;
        }
        .alert {
            display: none;
            margin-top: 15px;
            padding: 10px;
            color: white;
            text-align: center;
            border-radius: 4px;
        }
        .alert.success {
            background-color: #4caf50;
        }
        .alert.error {
            background-color: #f44336;
        }
        footer{
            background-color: #494848;
            margin-top: 130px;
            margin-bottom: 5px;
        }
        .logo-footer{
            width: 100px;
        }
        .footerUp {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 20px;
            color: white;
        }
        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        ul li {
            margin-bottom: 15px;
        }
        .footerDown {
            text-align: center;
            color: white;
            font-size: 0.8rem;
        }
        .footerDown p {
            margin: 0;
            padding: 5px 0;
        }
    </style>
</head>
<body>
    <header>
        <div class="header">
            <a href="Home.jsp">
                <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
            </a>
            
        </div>
    </header>

    <div class="container">
        <h2>Formulir Top Up</h2>
        <form action="TopUpServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="topup">Nominal Top Up (Rp):</label>
                <select id="topup" name ="topup">
                    <option value="">-- Pilih Nominal --</option>
                    <option value="10000">10.000</option>
                    <option value="20000">20.000</option>
                    <option value="50000">50.000</option>
                    <option value="100000">100.000</option>
                </select>
            </div>

            <div class="form-group">
                <label for="bukti">Unggah Bukti Pembayaran:</label>
                <input type="file" id="bukti" name="bukti" accept="image/*">
            </div>
            <button type="submit" value="submit">Submit</button>
            
        </form>
        
        <% String message = request.getParameter("message");%>
        <% if (message != null) {%>
            <div> <p id="message"><%= message %></p> </div>
        <% }%>
        <a href="Home.jsp">Kembali ke Home</a>
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
</html>
