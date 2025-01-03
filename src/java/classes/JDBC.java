/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author raya
 */
package classes;
import java.sql.*; 

/**
 *
 * @author raya
 */
public class JDBC {
    Connection con; 
    Statement stm; 
    ResultSet rs;
    public boolean isConnected; 
    public String message; 
    
    public JDBC() {
        try { 
            Class.forName("com.mysql.jdbc.Driver"); 
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_museum","root",""); 
            stm = con.createStatement();
            isConnected = true; 
            message = "DB connected"; 
        } catch(Exception e) { 
            isConnected = false; 
            message = e.getMessage(); 
        } 
    }
    public Connection getConnection() {
        return con; 
    }
    public void disconnect() { 
        try { 
            stm.close(); 
            con.close(); 
            message = "DB disconnected";
        } catch(Exception e) { 
            message = e.getMessage(); 
            } 
        }
}