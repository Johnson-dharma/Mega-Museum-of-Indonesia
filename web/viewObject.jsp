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
    <title>Object Page</title>
</head>
<body>
    <h1>Data Object</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Nama Object</th>
            <% if ("staff".equals(userType)) { %>
                <th>Action</th>
            <% } %>
        </tr>
        <%
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
        stmt = conn.createStatement();
        String query = "SELECT * FROM objects";
        rs = stmt.executeQuery(query);

        while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td>
                    <% 
                        Blob blob = rs.getBlob("image");
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
                    <form action="viewObjectDesc.jsp" method="get">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit"><%= rs.getString("title") %></button>
                    </form>
                </td>
                <% if ("staff".equals(userType)) { %>
                    <td>
                        <a href="editObject.jsp?id=<%= rs.getInt("id") %>">Edit</a>
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
        <a href="addObject.jsp" class="button">Add Object</a>
    <% } %>
    
    <a href="HomeServlet" class="button">Kembali ke Home</a>
</body>
</html>
