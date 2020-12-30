/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
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
public class adminloginresponse extends HttpServlet {

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            PrintWriter out = response.getWriter();
            String username = request.getParameter("username");
            String password = request.getParameter("password");


            ResultSet rs = DBLoader.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
            if (rs.next()) {
                request.getSession().setAttribute("adminusername", username);
                out.println("success");

            } else {
                
                out.println("fail");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
