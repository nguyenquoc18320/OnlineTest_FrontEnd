/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nguye
 */
@WebServlet(name = "Login", urlPatterns = {"/log-in"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/Login.jsp";
        HttpSession session = request.getSession();
        session.setAttribute("User", null);
        //from SignUp 
        String checkSignUp = request.getParameter("start");
        if (checkSignUp == null) {
//            try {
                String email = (String) request.getParameter("email");
                request.setAttribute("email", email);
                String password = (String) request.getParameter("password");
                request.setAttribute("password", password);
            
                String api_request = "http://localhost:8081/user/" + email + "/" + password;

                //get response from api
                String result = APIUtils.sendGetRequest(api_request, true);

                ObjectMapper mapper = new ObjectMapper();

                if (result != null) {
                    //login successfully
                    User user = mapper.readValue(result, User.class);
                    session.setAttribute("User", user);
//                    url = "/Views/Pages/Test/CreateTest.jsp";
//                    url="/create-test?start=1";
                      url = "/Views/Pages/User/UserInformation.jsp";

                    //url = "/Views/Pages/Course/CreateNewCourse.jsp";
//                    System.out.println("Login successfully");
                } else {
                    request.setAttribute("errorMessage", "Email or password is not correct!");
                }             
        
//        } catch (NullPointerException ex) {
//            //from other jsp pages
//            getServletContext().getRequestDispatcher(url).forward(request, response);
//            return;
//            } catch (Exception ex) {
////            System.out.println(ex.toString());
//                request.setAttribute("errorMessage", "Can't login!");
//            }
        }
        //getServletContext().getRequestDispatcher(url).forward(request, response);
        
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
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
