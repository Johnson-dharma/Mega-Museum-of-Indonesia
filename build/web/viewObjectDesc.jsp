<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String id = request.getParameter("id");
    String userType = (String) session.getAttribute("userType");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega Museum of Indonesia</title>
    <link rel="shortcut icon" href="Gambar/LOGO.png">
    <link rel="stylesheet" href="CSS/viewObjectDesc.css">
    <style>
        .back {
            position: absolute;
            top: 100px; /* Jarak dari atas */
            left: 20px; /* Jarak dari kanan */
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
    <div class="back">
        <a href="viewObject.jsp">
            <img src="Gambar/back.png" width="70">
        </a>
    </div>
        <div class="main">
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
                    String query = "SELECT * FROM objects WHERE id = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setInt(1, Integer.parseInt(id));
                    rs = stmt.executeQuery();

                    if (rs.next()) {
            %>
             <%if ("staff".equals(userType)) {%>
             
            <div class="tombol">
                <form action="DeleteObjectServlet" method="post" style="display: inline;">
                    <input type="hidden" name="id" value="<%= id%>">
                    <button type="submit">DELETE</button>
                </form>

                <form action="editObject.jsp" method="get" style="display: inline;">
                    <button type="submit" name="id" value="<%= rs.getInt("id")%>">EDIT</button>
                </form>
            </div>
                <br>
             
            <%}%>
            <h1><%= rs.getString("title")%></h1>
            <div class="content">
                <div class="frame">
                    <%
                        Blob blob = rs.getBlob("image");
                        if (blob != null) {
                            byte[] imageBytes = blob.getBytes(1, (int) blob.length());
                            String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                    %>
                    <img class="objek" src="data:image/jpeg;base64,<%= base64Image%>" width="300" height="300"/>
                    <%
                        } else {
                            out.println("No Image");
                        }
                    %> 
                </div>
            </div> 
                <br>
            <p> <%= rs.getString("description")%></p>
            <br>  


            <%
                    } else {
                        out.println("<p>Object not found.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                        if (stmt != null) {
                            stmt.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (Exception e) {
                        out.println("<p>Error menutup koneksi: " + e.getMessage() + "</p>");
                    }
                }
            %>
            <br>
        
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