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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega Museum of Indonesia</title>
    <link rel="shortcut icon" href="Gambar/LOGO.png">
    <link rel="stylesheet" href="CSS/articleCollection.css">
    <style>
        .btn {
            color: black;
            font-family: inherit;
            font-size: inherit;
            background: beige;
            padding: 0.3rem 3.4rem;
            border: 3px solid black;
            margin-left: 2.6rem;
            box-shadow: 0 0 0 black;
            transition: all 0.2s;
            margin-bottom: 20px;
        }

        .btn:last-child {
            margin: 0;
        }

        .btn:hover {
            box-shadow: 0.4rem 0.4rem 0 black;
            transform: translate(-0.4rem, -0.4rem);
        }

        .btn:active {
            box-shadow: 0 0 0 black;
            transform: translate(0, 0);
        }
    </style>
</head>
<body>
    <header>
        <div class="header">
            <%if ("staff".equals(userType)) {%>
            <a href="HomeStaff.jsp">
                <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
            </a>
            <%}else{%>
            <a href="Home.jsp">
                <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
            </a>
            <%}%>
        </div>
    </header>
    
    <h1>Article Collection</h1>
    <%if ("staff".equals(userType)) {%>
    <button class="btn" onclick="window.location.href='addArticle.jsp'">
            Add Article
    </button>
    <%}%>
    <div class="main">
        <div class="kotaks gambar-container">
            <%
    try {
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
        String query = "SELECT * FROM articles";
        stm = con.prepareStatement(query);
        rs = stm.executeQuery(query);
        while (rs.next()) {
        %>
            <% 
                Blob blob = rs.getBlob("image");
                if (blob != null) {
                    byte[] imageBytes = blob.getBytes(1, (int) blob.length());
                    String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
            %>
            <div class="gambar">
                <img src="data:image/jpeg;base64,<%= base64Image %>" width="100" height="100"/>
                <a href="viewArticle.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("title") %></a>
            </div>
            <%
                } else {
                    out.println("No Image");
                }
            %>
            <br>
            
        <%
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        jdbc.disconnect();
    }
    %>
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
</html>