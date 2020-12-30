<%-- 
    Document   : adminhome
    Created on : 29 Dec, 2020, 11:35:23 AM
    Author     : karan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <script>
            function gotomanagecategories()
            {
                location.href="managecategories.jsp";
            }
        </script>
    </head>
    <body>
        <button onclick="gotomanagecategories()" style="center">Manage Categories</button>
    </body>
</html>
