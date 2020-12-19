/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import vmm.DBLoader;
import vmm.FileUploader;

/**
 *
 * @author karan
 */
@MultipartConfig
public class usersignupresponse extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            PrintWriter out = response.getWriter();

            // write your logic here for signup
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phoneno = request.getParameter("phoneno");

            String absolutepath = request.getServletContext().getRealPath("/myuploads");
            Part filepart = request.getPart("userphoto");
            String filename = FileUploader.savefileonserver(filepart, absolutepath);

            String filepath = "myuploads/" + filename;

            ResultSet rs = DBLoader.executeQuery("select * from users where username='" + username + "'");

            if (rs.next()) {
                out.println("fail");
            } else {
                rs.moveToInsertRow();
                    rs.updateString("username", username);
                rs.updateString("password", password);
                rs.updateString("email", email);
                rs.updateString("phoneno", phoneno);
                rs.updateString("photo", filepath);
                rs.insertRow();
                out.println("success");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
