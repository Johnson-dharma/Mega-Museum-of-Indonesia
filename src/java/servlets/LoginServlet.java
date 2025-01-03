/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlets;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author raya
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC jdbc = new JDBC();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        String query = "SELECT * FROM users WHERE username = ? AND password = ? AND user_type = ?";
        
        try {
            java.sql.Connection con = jdbc.getConnection();
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            stm.setString(3, userType);
            
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Double megaWallet = rs.getDouble("megaWallet");
                String email = rs.getString("email");
                int id = rs.getInt("id");
                HttpSession session = request.getSession(); 
                session.setAttribute("username", username);
                session.setAttribute("userType", userType);
                session.setAttribute("megaWallet", megaWallet);
                session.setAttribute("email", email);
                session.setAttribute("id", id);
                
                if ("staff".equals(userType)) {
                    response.sendRedirect("HomeStaff.jsp");
                }else{
                    response.sendRedirect("Home.jsp");
                }
                
            }else{
                request.setAttribute("errorMessage", "Username atau Password Salah.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                out.println("Login Gagal");
            }
            
        } catch (Exception e){
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            jdbc.disconnect();
        }
    }
}
