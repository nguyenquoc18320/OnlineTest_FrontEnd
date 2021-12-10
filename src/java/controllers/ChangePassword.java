/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Account;
import Object.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PhanSu
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/change-pass"})
public class ChangePassword extends HttpServlet {

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
        String url = "/Views/Pages/User/ChangePassword.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
         String checkSrart = request.getParameter("start");
        if (checkSrart==null){
            String oldPassword = (String) request.getParameter("passwordold");
            request.setAttribute("passwordold", oldPassword);
            String newPassword = (String) request.getParameter("passwordnew");
            request.setAttribute("passwordnew", newPassword);
            String confirmPassword = (String) request.getParameter("confirmPassword");
            //check confirm password
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("confirmPasswordError", "*Confirmed password does NOT match!");
            } else if (newPassword.length()<8){
                request.setAttribute("passwordError", "Password must contain at least 8 characters!");
            }
            else {
                Account account = new Account(newPassword, oldPassword, user);
                //send http request to create new user
                ObjectMapper mapper = new ObjectMapper();
                String jsonRequest = mapper.writeValueAsString(account);
                String result = APIUtils.sendPutRequest("http://localhost:8081/account/"+user.getEmail(), jsonRequest);
                url = "/Views/Pages/User/Login.jsp";
                System.out.print("Ket qua:" +result);        
            }
        }
        getServletContext().getRequestDispatcher(url).forward(request, response);
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
