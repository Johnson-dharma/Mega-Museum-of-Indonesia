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

@WebServlet("/EditArticleServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class EditArticleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String existingImage = request.getParameter("existingImage");
        InputStream inputStream = null;
        
        PrintWriter out = response.getWriter();
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
            // Jika tidak ada gambar baru yang diunggah, ambil gambar yang ada dari parameter existingImage
            if (inputStream == null && existingImage != null && !existingImage.isEmpty()) {
                byte[] decodedBytes = Base64.getDecoder().decode(existingImage);
                inputStream = new java.io.ByteArrayInputStream(decodedBytes);
            }

            // Memperbarui data artikel termasuk gambar (jika ada)
            String updateSQL = "UPDATE articles SET title = ?, content = ?, image = ? WHERE id = ?";
            try {
                PreparedStatement stm = con.prepareStatement(updateSQL);
                stm.setString(1, title);
                stm.setString(2, content);
                if (inputStream != null) {
                    stm.setBlob(3, inputStream);
                } else {
                    stm.setNull(3, java.sql.Types.BLOB);
                }
                stm.setInt(4, Integer.parseInt(id));

                int row = stm.executeUpdate();
                if (row > 0) {
                    response.sendRedirect("Article.jsp");
                } else {
                    response.getWriter().println("Article update failed.");
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