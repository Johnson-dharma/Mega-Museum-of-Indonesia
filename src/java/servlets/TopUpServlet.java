package servlets;

import classes.JDBC;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/TopUpServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class TopUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC jdbc = new JDBC();
        String message ="";
        InputStream inputStream = null;
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        Part filePart = request.getPart("bukti");
        String topups = request.getParameter("topup");
        int topup = Integer.parseInt(topups);
        String username = (String) session.getAttribute("username"); 
        int id = (int) session.getAttribute("id"); 
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        String query = "INSERT INTO receipt (image,topup,userId,username) VALUES (?,?,?,?)";

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            PreparedStatement stm = con.prepareStatement(query);
            stm.setBlob(1, inputStream);
            stm.setInt(2, topup);
            stm.setInt(3, id);
            stm.setString(4, username);
            int rs = stm.executeUpdate();
            if (rs > 0) {
                response.sendRedirect("TopUp.jsp?message=Request+Top-up+berhasil%21");
            } else {
                out.print("insertion failed.");
            }
            
        } catch (Exception e) {
            e.getMessage();
            response.sendRedirect("TopUp.jsp??message=Request+Top-up+gagal%3A+" + URLEncoder.encode(e.getMessage(),"UTF-8"));
        }finally{
            jdbc.disconnect();
        }
    }
}
