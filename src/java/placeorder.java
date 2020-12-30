/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vmm.DBLoader;

/**
 *
 * @author karan
 */
public class placeorder extends HttpServlet {

  @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();

            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String username = request.getSession().getAttribute("username").toString();

            Date d = new Date();

            int totalprice = 0;

            ResultSet rs = DBLoader.executeQuery("select * from cart where username='" + username + "'");
            while (rs.next()) {
                int price = rs.getInt("price");
                int qty = rs.getInt("qty");

                totalprice += (price * qty);
            }

            ResultSet rs1 = DBLoader.executeQuery("select * from orders");
            rs1.moveToInsertRow();
            rs1.updateString("address", address);
            rs1.updateString("city", city);
            rs1.updateString("username", username);
            rs1.updateInt("totalprice", totalprice);
            rs1.updateInt("totalofferprice", totalprice);
            rs1.updateString("datetime", d + "");
            rs1.insertRow();

            ResultSet rs2 = DBLoader.executeQuery("select MAX(oid) as max from orders");
            rs2.next();
            int max = rs2.getInt("max");

            ResultSet rs3 = DBLoader.executeQuery("select * from cart where username='" + username + "'");
            while (rs3.next()) {
                int price = rs3.getInt("price");
                int qty = rs3.getInt("qty");
                int pid = rs3.getInt("pid");

                ResultSet rs4 = DBLoader.executeQuery("select * from orderdetails");
                rs4.moveToInsertRow();
                rs4.updateInt("price", price);
                rs4.updateInt("offerprice", price);
                rs4.updateInt("qty", qty);
                rs4.updateInt("pid", pid);
                rs4.updateInt("oid", max);
                rs4.insertRow();
                
                rs3.deleteRow();
                
            }

            out.println("<h1 style=\"text-align:center\">Your Order is Placed Successfully.<h1>");
            out.println("<a href=\"index.jsp\" style=\"text-align:center\">Go to Home</a>");
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
