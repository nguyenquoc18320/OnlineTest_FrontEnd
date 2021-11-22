/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "ForgetPassword_Login", urlPatterns = {"/pass-login"})
public class ForgetPassword_Login extends HttpServlet {

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
        String url = "/Views/Pages/User/SignUp.jsp";
        HttpSession session = request.getSession();
        session.setAttribute("User", null);
        String checkLogin = request.getParameter("start");
        if (checkLogin == null) {
            try {               
                String forgetemail = (String) request.getParameter("email-forget");
                request.setAttribute("email-forget", forgetemail);
                if (forgetemail==null) {
                    request.setAttribute("EmailFogetError", "*Email not null!");
                } else {
                    
                    String result = APIUtils.sendGetRequest("http://localhost:8081/user-email/" + forgetemail, true);
                    System.out.println("Result: " + result);

                    ObjectMapper mapper = new ObjectMapper();
                    List<User> userList = mapper.readValue(result, new TypeReference<List<User>>() {
                    });
                    //email no exists
                    if (userList.size()<1) {
                        request.setAttribute("EmailFogetError", "*Email not exist!");
                    } else {
                            //send code
                            User user = userList.get(0);
                            session.setAttribute("User", user);
                            APIUtils.sendGetRequest("http://localhost:8081/signup-code/" + forgetemail, true);                           
                            url = "/Views/Pages/User/ForgetPassword.jsp";
                            
                    }
                }
            } catch (Exception ex) {
                request.setAttribute("errorMessage", "*Can't sign up!");
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
