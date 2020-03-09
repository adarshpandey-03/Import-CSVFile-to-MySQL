<%-- 
    Document   : showData
    Created on : Feb 23, 2020, 6:09:57 PM
    Author     : Adarsh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Data</title>
    </head>
    <body>
        <%
            try {
                String url ="jdbc:mysql://localhost:3306/csvfile";
                String username="root";
                String password="password@123";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(url,username,password);
                
                Statement statement = null;
                ResultSet rs = null;
                
                statement = con.createStatement();
                
                String query = "Select * from UserData";
                rs = statement.executeQuery(query);
            %>
            <table cellpadding="15" border="1">
            <tr><th>Name</th><th>Email</th><th>Phone Number</th></tr>
            <%
            while(rs.next()){                
            %>  
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
            </tr>
            <% } %>
            
            <%
            //close all the connection
            rs.close();
            statement.close();
            con.close();            
            %>
            <%
            } catch (Exception e) {
                e.printStackTrace();
            }
            %> 
        
        
        </table>
            
    </body>
</html>
