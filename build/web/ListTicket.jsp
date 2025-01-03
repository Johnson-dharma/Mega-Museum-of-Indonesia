<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="classes.JDBC"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;
    JDBC jdbc = new JDBC();
    String message = "";
%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Tiket</title>
    <link rel="stylesheet" href="CSS/ListTicket.css">
    <style>
        footer {
            background-color: #4a4a4a;
            color: white;
            padding: 10px;
            margin-top: 300px;
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="Home.jsp">
            <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
        </a>
    </div>

    <div class="container">
        <h2>List Tiket</h2>
        <% 
        
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            String query = "SELECT * FROM tickets WHERE user_id = ?";
            session = request.getSession();
            Integer id = (Integer) session.getAttribute("id");
            stm = con.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            
            
            
            while (rs.next()) {
            %>
                <tbody>
                    <tr>
                        <div class="ticket">
                        <%
                            int userId = rs.getInt("user_id");
                            String location = rs.getString("location");  
                        %>
                        <%if (userId == id) {%>
                        <% if (location.equals("Museum-Bank-Indonesia")) { %>
                                <img src="Gambar/Museum_Bank_Indonesia.jpg" alt="Museum Image1">
                            <%}else if ("Museum-Nasional-Indonesia".equals(location)){%>
                                <img src="Gambar/Museum_Nasional_Indonesia.jpg" alt="Museum Image2">
                            <%}else if ("Museum-Pos-Indonesia".equals(location)){%>
                                <img src="Gambar/Museum-Pos-Indonesia.jpg" alt="Museum Image3">
                            <%}else if (location.equals("Museum-Wayang")){%>
                                <img src="Gambar/MuseumWayang.jpg" alt="Museum Image4">
                            <%}else if (location.equals("Museum-Fatahillah")){%>
                                <img src="Gambar/Museum_Fatahillah.jpg" alt="Museum Image5">
                            <%}else {%>
                                <img src="Gambar/MuseumTamanPrasasti.jpg" alt="Museum Image6">
                            <% }%>
                            <div class="ticket-info">
                                <p><strong><%= location %></strong></p>
                                <p>Tanggal: <%= rs.getString("date")%></p> 
                                <p>ID Tiket: <%= rs.getString("ticket_id") %></p> 
                            </div>
                            <div class="scan-qr">
                                <p>Scan QR:</p>
                                <img src="Gambar/QRCode.png" alt="QR Code">
                            </div>
                        <%}%>    
                        </div>
                    </tr>
                </tbody>
            <%
            }
        } catch (Exception e) {

            message = e.getMessage();
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            jdbc.disconnect();
        }
            %>
            
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

