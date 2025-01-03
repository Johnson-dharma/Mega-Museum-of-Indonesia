package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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

@WebServlet("/AddArticleServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class AddArticleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        InputStream inputStream = null;

        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        String query = "INSERT INTO articles (title, content, image) VALUES (?, ?, ?)";

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, title);
            stm.setString(2, content);
            if (inputStream != null) {
                stm.setBlob(3, inputStream);
            } else {
                stm.setNull(3, java.sql.Types.BLOB);
            }

            int row = stm.executeUpdate();
            if (row > 0) {
                response.sendRedirect("Article.jsp");
            } else {
                out.print("Article insertion failed.");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
