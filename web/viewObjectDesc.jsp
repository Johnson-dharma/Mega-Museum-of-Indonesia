<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String id = request.getParameter("id");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Object Description</title>
</head>
<body>
    <h1>Deskripsi Object</h1>
    <%
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
        String query = "SELECT * FROM objects WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(id));
        rs = stmt.executeQuery();

        if (rs.next()) {
    %>
            <p><strong>ID Object:</strong> <%= rs.getInt("id") %></p>
            <p><strong>Nama Object:</strong> <%= rs.getString("title") %></p>
            <p><strong>Deskripsi:</strong> <%= rs.getString("description") %></p>
            <p><strong>Image:</strong><br>
                <%
                    Blob blob = rs.getBlob("image");
                    if (blob != null) {
                        byte[] imageBytes = blob.getBytes(1, (int) blob.length());
                        String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                %>
                    <img src="data:image/jpeg;base64,<%= base64Image %>" width="300" height="300"/>
                <%
                    } else {
                        out.println("No Image");
                    }
                %>
            </p>
    <%
        } else {
            out.println("<p>Object not found.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            out.println("<p>Error menutup koneksi: " + e.getMessage() + "</p>");
        }
    }
    %>
    <br>
    <a href="viewObject.jsp" class="button">Kembali ke Daftar Objek</a>
</body>
</html>
