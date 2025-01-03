<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.http.Part"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.JDBC"%>


<%--
    Document   : editObject
    Created on : 11 Dec 2024, 10.38.26
    Author     : raya
--%>

<%
    request.setCharacterEncoding("UTF-8");

    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;
    String id = request.getParameter("id");
    String title = "";
    String description = "";
    byte[] image = null;
    JDBC jdbc = new JDBC(); 


    // ambil data objek dari database
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            String query = "SELECT * FROM objects WHERE id = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, Integer.parseInt(id));
            rs = stm.executeQuery();

            if (rs.next()) {
                title = rs.getString("title");
                description = rs.getString("description");
                image = rs.getBytes("image");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            jdbc.disconnect();
        }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mega Museum of Indonesia</title>
    <style>
        body {
            background-color: #f0f0f0; /* Warna abu muda */
            font-family: Arial, sans-serif;
            color: #333;
            padding: 20px;
        }

        h1 {
            color: #2c3e50; /* Biru tua */
            text-align: center;
        }

        form {
            background-color: #e6e2d3; /* Beige */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
        }

        label {
            font-size: 16px;
            color: #2c3e50; /* Biru tua */
        }

        input[type="text"], textarea, input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            background-color: #2c3e50; /* Biru tua */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #34495e; /* Biru lebih gelap */
        }

        a {
            color: #2c3e50;
            text-decoration: none;
            font-size: 16px;
            margin-top: 20px;
            display: inline-block;
            text-align: center;
            transition: color 0.3s;
        }

        a:hover {
            color: #34495e; /* Biru lebih gelap saat hover */
        }
    </style>
</head>
<body>
    <h1>Edit Object</h1>
    <form action="EditObjectServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="existingImage" value="<%= image != null ? Base64.getEncoder().encodeToString(image) : "" %>">
        <label for="title">Nama Object:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required><br><br>
        
        <label for="description">Description:</label><br>
        <textarea id="description" name="description" rows="10" cols="50" required><%= description %></textarea><br><br>

        <% if (image != null && image.length > 0) { %>
            <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(image) %>" alt="Object Image" width="100"><br><br>
        <% } %>

        <label for="image">Image:</label><br>
        <input type="file" id="image" name="image"><br><br>

        <button type="submit">Update</button>
    </form>
    <br>
    <a href="viewObject.jsp">Kembali</a>
</body>
</html>
