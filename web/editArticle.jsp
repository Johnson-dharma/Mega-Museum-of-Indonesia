<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.http.Part"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--
    Document   : editArticle
    Created on : 11 Dec 2024, 10.38.26
    Author     : raya
--%>

<%
    request.setCharacterEncoding("UTF-8");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String id = request.getParameter("id");
    String title = "";
    String content = "";
    byte[] image = null;

    // ambil data artikel dari database
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            String query = "SELECT * FROM articles WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(id));
            rs = stmt.executeQuery();

            if (rs.next()) {
                title = rs.getString("title");
                content = rs.getString("content");
                image = rs.getBytes("image");
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
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Article</title>
</head>
<body>
    <h1>Edit Article</h1>
    <form action="EditArticleServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="existingImage" value="<%= image != null ? Base64.getEncoder().encodeToString(image) : "" %>">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required><br><br>
        
        <label for="content">Content:</label><br>
        <textarea id="content" name="content" rows="10" cols="50" required><%= content %></textarea><br><br>

        <% if (image != null && image.length > 0) { %>
            <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(image) %>" alt="Article Image" width="100"><br><br>
        <% } %>

        <label for="image">Image:</label><br>
        <input type="file" id="image" name="image"><br><br>

        <button type="submit">Update</button>
    </form>
    <br>
    <a href="Article.jsp">Kembali</a>
</body>
</html>
