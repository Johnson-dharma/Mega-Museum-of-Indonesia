/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author raya
 */
@WebServlet(name = "VerifTopUpServlet", urlPatterns = {"/VerifTopUpServlet"})
public class VerifTopUpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        JDBC jdbc = new JDBC();
        PrintWriter out = response.getWriter();
        String ids = request.getParameter("id");
        String userIds = request.getParameter("userId");
        
        int id = Integer.parseInt(ids);
        int userId = Integer.parseInt(userIds);
        String pilih = request.getParameter("pilih");
        
        if ("approve".equals(pilih)){
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
                String updateSQL = "DELETE FROM receipt WHERE id = ?";
                String getSaldoU = "SELECT megaWallet FROM users WHERE id = ?";
                String getSaldoT = "SELECT topup FROM receipt WHERE id = ?";
                String setSaldoU = "UPDATE users SET megaWallet = ? WHERE id = ?";
                PreparedStatement stmU = con.prepareStatement(getSaldoU);
                PreparedStatement stmT = con.prepareStatement(getSaldoT);
                PreparedStatement stmUpdate = con.prepareStatement(setSaldoU);
                stmU.setInt(1, userId);
                stmT.setInt(1, id);
                ResultSet rsU = stmU.executeQuery();
                ResultSet rsT = stmT.executeQuery();

                int megaWallet = 0;
                int topup = 0;
                if (rsU.next()) { 
                    megaWallet = rsU.getInt("megaWallet"); 
                } 
                if (rsT.next()) { 
                    topup = rsT.getInt("topup"); 
                }
                megaWallet = megaWallet + topup;
                PreparedStatement stm = con.prepareStatement(updateSQL);
                stm.setInt(1, id);
                stm.executeUpdate();
                
                stmUpdate.setInt(1, megaWallet); 
                stmUpdate.setInt(2, userId);
                stmUpdate.executeUpdate();
                
                response.sendRedirect("VerifTopUp.jsp");
            }catch (Exception e){
                out.print(e.getMessage());
            }finally{
                jdbc.disconnect();
            }
            

        }else{
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum", "root", "");
                String updateSQL = "DELETE FROM receipt WHERE id = ?;";
                PreparedStatement stm = con.prepareStatement(updateSQL);
                stm.setInt(1, id);
                stm.executeUpdate();
            }catch (Exception e){
                out.print(e.getMessage());
            }finally{
                jdbc.disconnect();
            }
            response.sendRedirect("VerifTopUp.jsp");

        }
    }


}
