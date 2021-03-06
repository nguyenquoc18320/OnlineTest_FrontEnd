/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.User;
import java.io.IOException;
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
@WebServlet(name = "DeleteCourse", urlPatterns = {"/delete-course"})
public class DeleteCourse extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/Course/EditCourse.jsp";

        HttpSession session = request.getSession();

        //check whether user logined
        User user = (User) session.getAttribute("user");

        try {
            if (user == null) {
                url = "/Views/Pages/User/Login.jsp";
            } else {
                String courseid = request.getParameter("courseid");

                if (courseid == null || courseid.isEmpty()) {
                    request.setAttribute("errorMessage", "Can't not delete course!");
                } else {
                    //set api request
                    String api_url = APIUtils.getBaseURLAPi() + "course/delete?userid=" + user.getId()
                            + "&courseid=" + courseid;

                    String result = APIUtils.sendPutRequest(api_url, "");

                    if (result != null) {
                        request.setAttribute("deleteMessage", result);
                    } else {
                        request.setAttribute("deleteMessage", "Can't not delete course!");
                    }

                    url = "/manage-course-user";
                }

            }
        } catch (Exception ex) {
            System.out.println(ex.toString());
            request.setAttribute("errorMessage", "Can't not delete course!");
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
