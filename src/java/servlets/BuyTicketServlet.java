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
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "BuyTicketServlet", urlPatterns = {"/BuyTicketServlet"})
public class BuyTicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC jdbc = new JDBC();
        ResultSet rs = null;
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String date = request.getParameter("date");
        String location = request.getParameter("location");
        String squantity = request.getParameter("quantity");
        String lctn;
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String formattedDate = sdf.format(new Date());
        int quantity = Integer.parseInt(squantity);
        int user_id = (int) session.getAttribute("id");
        String queryInsert = "INSERT INTO tickets (ticket_id, user_id, quantity, price, date, location) VALUES (?, ?, ?, ?, ?, ?);";
        String queryUpdateWallet = "UPDATE users SET megaWallet = ? WHERE id = ?;";
        String queryGetWallet = "SELECT megaWallet FROM users WHERE id = ?;";
        double megaWallet = 0;
        
        try {
            // Ambil saldo pengguna
            java.sql.Connection con = jdbc.getConnection();
            PreparedStatement stm = con.prepareStatement(queryGetWallet);
            stm.setInt(1, user_id);
            rs = stm.executeQuery();
            if (rs.next()) {
                megaWallet = rs.getDouble("megaWallet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Tentukan harga tiket berdasarkan lokasi
        double price = 0;
        if ("Museum-Bank-Indonesia".equals(location)) {
            price = 50000 * quantity;
            lctn = "MBI";
        } else if ("Museum-Nasional-Indonesia".equals(location)) {
            price = 40000 * quantity;
            lctn = "MNI";
        } else if ("Museum-Pos-Indonesia".equals(location)) {
            price = 15000 * quantity;
            lctn = "MPI";
        } else if ("Museum-Wayang".equals(location)) {
            price = 30000 * quantity;
            lctn = "MW";
        } else if ("Museum-Fatahillah".equals(location)) {
            price = 10000 * quantity;
            lctn = "MF";
        } else {
            price = 60000 * quantity;
            lctn = "MTP";
        }
        
        String ticketId = lctn + "-" + formattedDate + "-" + user_id;

        try {
            if (megaWallet >= price) {
                // Update saldo pengguna
                double updatedWallet = megaWallet - price;
                java.sql.Connection con = jdbc.getConnection();
                PreparedStatement stmUpdateWallet = con.prepareStatement(queryUpdateWallet);
                stmUpdateWallet.setDouble(1, updatedWallet);
                stmUpdateWallet.setInt(2, user_id);
                stmUpdateWallet.executeUpdate();

                // Masukkan data tiket ke tabel
                PreparedStatement stmInsert = con.prepareStatement(queryInsert);
                stmInsert.setString(1, ticketId);
                stmInsert.setInt(2, user_id);
                stmInsert.setInt(3, quantity);
                stmInsert.setDouble(4, price);
                stmInsert.setString(5, date);
                stmInsert.setString(6, location);
                int result = stmInsert.executeUpdate();
                
                if (result > 0) {
                    request.getRequestDispatcher("InformasiTransaksi.jsp").forward(request, response);
                } else {
                    request.setAttribute("result", "failure");
                    out.println("Gagal Membuat Ticket");
                    request.getRequestDispatcher("BuyTicket.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("result", "insufficient");
                request.setAttribute("errorMessage", "Saldo tidak mencukupi.");
                request.getRequestDispatcher("BuyTicket.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            jdbc.disconnect();
        }
    }
}

