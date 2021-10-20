/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Account;
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

@WebServlet(name = "SignUp", urlPatterns = {"/sign-up"})
public class SignUp extends HttpServlet {

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

        request.setCharacterEncoding("UTf-8");
        response.setCharacterEncoding("UTF-8");

        String url = "/Views/Pages/User/SignUp.jsp";

        //from login 
        String checkLogin = request.getParameter("start");
        if (checkLogin == null) {
            try {
                String name = (String) request.getParameter("name");
                request.setAttribute("name", name);
                String email = (String) request.getParameter("email");
                request.setAttribute("email", email);
                String password = (String) request.getParameter("password");
                request.setAttribute("password", password);
                String confirmPassword = (String) request.getParameter("confirmPassword");

                //check whether pass and confirmed pass match
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("confirmPasswordError", "*Confirmed password does NOT match!");
                } else {
                    //check whether email exits
                    String result = APIUtils.sendGetRequest("http://localhost:8081/user-email/" + email, true);
                    System.out.println("Result: " + result);

                    ObjectMapper mapper = new ObjectMapper();
                    List<User> userList = mapper.readValue(result, new TypeReference<List<User>>() {
                    });

                    //email exists
                    if (userList.size() > 0) {
                        request.setAttribute("emailError", "*Email exist!");
                    } else {
//                        //create user
//                        User user = new User(name, null, null, email);
//                        Account account = new Account(password, "1", user);
//
//                        //send http request to create new user
//                        String jsonRequest = mapper.writeValueAsString(account);
//                        result = APIUtils.sendPostRequest("http://localhost:8081/account", jsonRequest);
//
//                        account = mapper.readValue(result, Account.class);
//                        if (account == null) {
//                            request.setAttribute("errorMessage", "*Can't sign up! Please check infomation!");
//                        } else {
//                            //sign up successfully
//                        }
//
//                        System.out.println(account);

                            //send code to confirm the email
                            APIUtils.sendGetRequest("http://localhost:8081/signup-code/" + email, false); 
                            
                            url = "/Views/Pages/User/ConfirmSignUpCode.jsp";
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
