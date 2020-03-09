package servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig()
public class uploadServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            Part part = request.getPart("csvfile");
            String fileName = part.getSubmittedFileName();
           // out.println(fileName);

            try {
                String url ="jdbc:mysql://localhost:3306/csvfile";
                String username="root";
                String password="password@123";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(url,username,password);
                
                System.out.println(con);
                //query........

                //Upload...
                InputStream is = part.getInputStream();     
                byte[] file = new byte[is.available()];     //to read data 

                is.read(file);
                String path = request.getRealPath("/") + "files" + File.separator + fileName;
                //out.println(path);

                FileOutputStream fos = new FileOutputStream(path);
                fos.write(file);
                fos.close();
                

                String q = "insert into userdata(Name,Email,Phone_Number) values(?,?,?)";
                PreparedStatement statement = con.prepareStatement(q);

                BufferedReader lineReader = new BufferedReader(new FileReader(path));
                String lineText = null;
                out.println("Done");
                while ((lineText = lineReader.readLine()) != null) {
                    String[] data = lineText.split(",");
                    String name = data[0];
                    String email = data[1];
                    String phoneNumber = data[2];

                    statement.setString(1, name);
                    statement.setString(2, email);
                    statement.setString(3, phoneNumber);

                    statement.executeUpdate();
                }
                
            } catch (Exception ex) {
                ex.printStackTrace();
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
