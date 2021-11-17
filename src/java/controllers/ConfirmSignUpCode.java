/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Account;
import Object.Role;
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

@WebServlet(name = "ConfirmSignUpCode", urlPatterns = {"/confirm-signup-code"})
public class ConfirmSignUpCode extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/ConfirmSignUpCode.jsp";

        HttpSession session = request.getSession();

        String name = request.getParameter("name");
        request.setAttribute("name", name);
        String email = request.getParameter("email");
        request.setAttribute("email", email);
        String password = request.getParameter("password");
        request.setAttribute("password", password);

        if (name != null && email != null && password != null && !name.isEmpty()
                && !email.isEmpty() && !password.isEmpty()) {

            String code = (String) request.getParameter("number1")
                    + (String) request.getParameter("number2")
                    + (String) request.getParameter("number3")
                    + (String) request.getParameter("number4")
                    + (String) request.getParameter("number5")
                    + (String) request.getParameter("number6");

            Role role = new Role(2L, "User");
            User user = new User(name, null, null, email, role);
            Account account = new Account(password, "1", user);

            //send http request to create new user
            ObjectMapper mapper = new ObjectMapper();
            String jsonRequest = mapper.writeValueAsString(account);
            String result = APIUtils.sendPostRequest("http://localhost:8081/account/" + code, jsonRequest);

            System.out.print("Ket qua:" + result);

            if (result != null) {
                account = mapper.readValue(result, Account.class);
                System.out.print(account);
                user = account.getUser();
                session.setAttribute("user", user);

                //check role
                if (user.getRole().getId() == 1) {

//                url = "/Views/"
                } else {
                    url = "/manage-course-user?page=1&limit=5";
                }
                //sign up successfully
            } else {
                //sign up successfully
                request.setAttribute("errorMessage", "The code is incorrect!");
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
