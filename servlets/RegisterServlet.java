package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import classess.JDBC;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String userType = request.getParameter("userType");

        JDBC jdbc = new JDBC();
        if (!jdbc.isConnected) {
            response.getWriter().println("Database connection failed: " + jdbc.message);
            return;
        }

        try {
            String query = "INSERT INTO users (username, password, email, user_type) VALUES (?, ?, ?, ?)";
            try (Connection con = jdbc.getConnection();
                 PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                stmt.setString(3, email);
                stmt.setString(4, userType);

                // menjalankan query 
                int result = stmt.executeUpdate();
                if (result > 0) { // jika erjadi perubahan pada db
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                } else {
                    response.setContentType("text/html;charset=UTF-8");
                    try (PrintWriter out = response.getWriter()) {
                        out.println("<html><body>");
                        out.println("<h2>Registrasi gagal!</h2>");
                        out.println("<a href='Register.jsp'>Coba lagi</a>");
                        out.println("</body></html>");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            jdbc.disconnect();
        }
    }
}
