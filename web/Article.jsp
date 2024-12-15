<%-- 
    Document   : Article
    Created on : 10 Dec 2024, 21.02.01
    Author     : raya
--%>
<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null; 
    String userType = (String) session.getAttribute("userType"); 
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Article Page</title>
</head>
<body>
    <h1>Data Article</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Nama Article</th>
            <% if ("staff".equals(userType)) { %> 
                <th>Action</th>
            <% } %>
        </tr>
        <%
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM articles");

        while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td> 
                    <% Blob blob = rs.getBlob("image"); 
                        if (blob != null) { 
                            byte[] imageBytes = blob.getBytes(1, (int) blob.length()); 
                            String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes); 
                    %> 
                        <img src="data:image/jpeg;base64,<%= base64Image %>" width="100" height="100"/> 
                    <% 
                        } else { 
                            out.println("No Image"); 
                        } 
                    %> 
                </td>
                <td>
                    <form action="viewArticle.jsp" method="get">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit"><%= rs.getString("title") %></button>
                    </form>
                </td>
                <% if ("staff".equals(userType)) { %> 
                    <td> 
                        <a href="editArticle.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                    </td>   
                <% } %> 
                
            </tr>
        <%
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

    </table>
    <br>
    <% if ("staff".equals(userType)) { %> 
        <a href="addArticle.jsp" class="button">Add Article</a>
    <% } %>
    
    <a href="HomeServlet" class="button">Kembali ke Home</a>
</body>
</html>
