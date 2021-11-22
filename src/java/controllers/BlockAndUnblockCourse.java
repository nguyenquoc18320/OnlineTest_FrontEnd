/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.User;
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
 * @author nguye
 */
@WebServlet(name = "BlockAndUnblockCourse", urlPatterns = {"/block-unblock-course"})
public class BlockAndUnblockCourse extends HttpServlet {

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

        //check whether logining
        if (user == null || user.getRole().getId() != 1) {
            url = "/log-in?start=1";
        } else {

            String userid = request.getParameter("userid");
            request.setAttribute("userid", userid);
            url = "/user-course-admin?userid=" + userid;
            
            try {
                //block or not
                String courseid = request.getParameter("courseid");
//                request.setAttribute("courseid", courseid);
                boolean blocked = Boolean.parseBoolean(request.getParameter("blocked"));

                String api_url = "";
    
                if (blocked) {
                    api_url = APIUtils.getBaseURLAPi() + "course/block?userid=" + user.getId()
                            + "&courseid=" + courseid;
                } else {
                    api_url = APIUtils.getBaseURLAPi() + "course/unblock?userid=" + user.getId()
                            + "&courseid=" + courseid;
                }

                String result = APIUtils.sendPutRequest(api_url, "");

                if (result != null) {
                    request.setAttribute("blockMessage", result);
                } else {
                    request.setAttribute("blockMessage", "Error!");
                }
            } catch (Exception ex) {
                System.out.println(ex.toString());
//                url = "/user-course-admin?userid=" + userid;
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
