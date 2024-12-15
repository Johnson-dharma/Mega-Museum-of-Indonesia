package servlets;

import java.io.IOException;
import java.io.InputStream;
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

@WebServlet("/EditObjectServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class EditObjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String existingImage = request.getParameter("existingImage");
        InputStream inputStream = null;

        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        String url = "jdbc:mysql://localhost:3306/db_museum";
        String username = "root";
        String password = "";

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            // Jika tidak ada gambar baru yang diunggah, ambil gambar yang ada dari parameter existingImage
            if (inputStream == null && existingImage != null && !existingImage.isEmpty()) {
                byte[] decodedBytes = Base64.getDecoder().decode(existingImage);
                inputStream = new java.io.ByteArrayInputStream(decodedBytes);
            }

            // Memperbarui data objek termasuk gambar (jika ada)
            String updateSQL = "UPDATE objects SET title = ?, description = ?, image = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {
                pstmt.setString(1, title);
                pstmt.setString(2, description);
                if (inputStream != null) {
                    pstmt.setBlob(3, inputStream);
                } else {
                    pstmt.setNull(3, java.sql.Types.BLOB);
                }
                pstmt.setInt(4, Integer.parseInt(id));

                int row = pstmt.executeUpdate();
                if (row > 0) {
                    response.sendRedirect("viewObject.jsp");
                } else {
                    response.getWriter().println("Object update failed.");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new ServletException(ex);
        }
    }
}
