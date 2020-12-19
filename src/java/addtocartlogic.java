/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vmm.DBLoader;

/**
 *
 * @author karan
 */
public class addtocartlogic extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        try {

            if (request.getSession().getAttribute("username") == null) {
                out.println("not logged in");
            } else {
                String pid = request.getParameter("pid");
                String name = request.getParameter("name");
                String price = request.getParameter("price");

                String username = request.getSession().getAttribute("username").toString();

                ResultSet rs = DBLoader.executeQuery("select * from cart where pid='" + pid + "' and username='" + username + "'");
                if (rs.next())
                {
                    int qty = rs.getInt("qty");
                    qty++;
                    rs.updateInt("qty", qty);
                    rs.updateRow();
                } else {
                    rs.moveToInsertRow();
                    rs.updateInt("pid", Integer.parseInt(pid));
                    rs.updateString("productname", name);
                    rs.updateInt("price", Integer.parseInt(price));
                    rs.updateInt("qty", 1);
                    rs.updateString("username", username);
                    rs.insertRow();
                }
                out.println("success");

            }
        } catch (Exception e) 
        {
            e.printStackTrace();
        }

    }

    }

    
  

