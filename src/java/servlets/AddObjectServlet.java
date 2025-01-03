package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/AddObjectServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class AddObjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        InputStream inputStream = null;

        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        String sql = "INSERT INTO objects (title, description, image) VALUES (?, ?, ?)";
        String url = "jdbc:mysql://localhost:3306/db_museum";
        String username = "root";
        String password = "";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, title);
            pstmt.setString(2, description);
            if (inputStream != null) {
                pstmt.setBlob(3, inputStream);
            } else {
                pstmt.setNull(3, java.sql.Types.BLOB);
            }

            int row = pstmt.executeUpdate();
            if (row > 0) {
                response.sendRedirect("viewObject.jsp");
            } else {
                response.getWriter().println("Object insertion failed.");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
