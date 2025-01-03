package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/DeleteObjectServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class DeleteObjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            String updateSQL = "DELETE FROM objects WHERE id = ?;";
            try {
                PreparedStatement stm = con.prepareStatement(updateSQL);
                stm.setString(1, id);
                int row = stm.executeUpdate();
                if (row > 0) {
                    response.sendRedirect("viewObject.jsp");
                } else {
                    response.getWriter().println("Delete Object failed.");
                }
            }catch (Exception e){
                out.print(e.getMessage());
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new ServletException(ex);
        }
    }
}
