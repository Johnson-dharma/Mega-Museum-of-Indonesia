<%-- 
    Document   : viewArticle
    Created on : 11 Dec 2024, 14.28.24
    Author     : raya
--%>

<%@page import="java.sql.*"%>
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
    <title>Article Content</title>
</head>
<body>
    <h1>Article Content</h1>
    <%
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
        String query = "SELECT * FROM articles WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(id));
        rs = stmt.executeQuery();

        if (rs.next()) {
    %>
            <p><strong>ID:</strong> <%= rs.getInt("id") %></p>
            <p><strong>Judul Article:</strong> <%= rs.getString("title") %></p>
            <p><strong>Content:</strong> <%= rs.getString("content") %></p>
    <%
        } else {
            out.println("<p>Article not found.</p>");
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
    <a href="Article.jsp" class="button">Kembali ke Daftar Article</a>
</body>
</html>
