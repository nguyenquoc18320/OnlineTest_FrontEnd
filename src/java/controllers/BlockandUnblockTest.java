/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Course;
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
 * @author PhanSu
 */
@WebServlet(name = "BlockandUnblockTest", urlPatterns = {"/block-unblock-test"})
public class BlockandUnblockTest extends HttpServlet {
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

        String url = "";

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");
        String api_url = APIUtils.getBaseURLAPi();
        ObjectMapper mapper = new ObjectMapper();
        try {
            if (user == null) {
                url = "/Views/Pages/User/Login.jsp";
            } else {
                String courseid = request.getParameter("courseid");
                String courseD = APIUtils.sendGetRequest(api_url + "course/" + courseid, true);
                Course course = mapper.readValue(courseD, Course.class);               
                if (course == null) {
                    request.setAttribute("errorMessage", "Can't not delete course!");
                } else {
                    String testid = request.getParameter("testid");
                    String result = APIUtils.sendPutRequest(APIUtils.getBaseURLAPi() + "change-status-test/" + courseid+ "/" + testid ,"");
                    if (result != null) {
                        request.setAttribute("alertMessage", "Changed the test status ");
                        url= "list-test?courseid="+courseid+"&start=1";
                    } else {
                        request.setAttribute("alertMessage", "Can't not change the test status !");
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println(ex.toString());
            request.setAttribute("errorMessage", "Can't not change status test!");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        dispatcher.forward(request, response);
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
