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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Daftar Transaksi Pembayaran</title>
        <link rel="stylesheet" href="CSS/Verification.css">
    </head>
<body>
    <div class="container">
        <h2>Daftar Transaksi Pembayaran</h2>
        <table>
        <% 
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            String query = "SELECT * FROM receipt";
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
                <thead>
                    <tr>
                        <th>ID Transaksi</th>
                        <th>User ID</th>
                        <th>Nama Pengguna</th>
                        <th>Bukti</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getInt("userId") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td><img src="data:image/jpeg;base64,<%= base64Image %>" width="200" height="450"/></td>
                        <form action="VerifTopUpServlet" method="post">
                        <td>
                            <input type="hidden" name ="id" value="<%= rs.getInt("id") %>">
                            <input type="hidden" name ="userId" value="<%= rs.getInt("userId") %>">
                            <button type="submit" name ="pilih" class="btn" value="approve" >Approve</button>
                            <button type="submit" name ="pilih" class="btn btn-reject" value="reject" >Reject</button>
                        </td>
                        </form>
                    </tr>
                </tbody>
                <%
                    } else {
                        out.println("No Image");
                    }
                %>
            <%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            jdbc.disconnect();
        }
            %>
            
        <a href ="HomeStaff.jsp">Kembali ke Home</a>
</body>
</html>
