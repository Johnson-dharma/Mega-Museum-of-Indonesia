package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import classess.JDBC;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        JDBC jdbc = new JDBC();
        if (!jdbc.isConnected) {
            response.getWriter().println("Database connection failed: " + jdbc.message);
            return;
        }

        try {
            String query = "SELECT * FROM users WHERE username = ? AND password = ? AND user_type = ?";
            try (Connection con = jdbc.getConnection();
                 PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                stmt.setString(3, userType);

                ResultSet rs = stmt.executeQuery();
                if (rs.next()) { // cek hasil query SELECT
                    Double megaWallet = rs.getDouble("megaWallet");
                    HttpSession session = request.getSession(); 
                    session.setAttribute("username", username);
                    session.setAttribute("userType", userType);
                    session.setAttribute("megaWallet", megaWallet);
                    
                    response.sendRedirect("HomeServlet");
                } else {
                    response.setContentType("text/html;charset=UTF-8");
                    try (PrintWriter out = response.getWriter()) {
                        out.println("<html><body>");
                        out.println("<h2>Login gagal!</h2>");
                        out.println("<a href='Login.jsp'>Coba lagi</a>");
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
