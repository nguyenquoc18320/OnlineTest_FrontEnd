/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Course;
import Object.EntityPagination;
import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
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
 * @author nguye
 */
@WebServlet(name = "AttendedCourse", urlPatterns = {"/attended-course"})
public class AttendedCourse extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/AttendedCourses.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            url = "/log-in?start=1";
        } else if (user.getRole().getId() != 2) {//not user role
            url = "/manager-course-admin";
        } else {

            int page = 1;
            int maxPageItems = 5;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                maxPageItems = Integer.parseInt(request.getParameter("maxPageItems")); //number of items per a page
                request.setAttribute("maxPageItems", maxPageItems);
            } catch (Exception ex) {
            }

            //get course list user attended
            String api_url = APIUtils.getBaseURLAPi() + "join-course/get-course-list?userid=" + user.getId()
                    + "&page=" + page + "&limit=5" + maxPageItems;

            String result = APIUtils.sendGetRequest(api_url, true);

            if (result != null) {
                ObjectMapper mapper = new ObjectMapper();
                EntityPagination<Course> coursePagination = mapper.readValue(result, new TypeReference<EntityPagination<Course>>() {
                });
                request.setAttribute("coursePagination", coursePagination);
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
