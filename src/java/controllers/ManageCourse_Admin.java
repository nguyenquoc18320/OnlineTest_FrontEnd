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
@WebServlet(name = "ManageCourse_Admin", urlPatterns = {"/manage-course-admin"})
public class ManageCourse_Admin extends HttpServlet {

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

        HttpSession session = request.getSession();
        String url = "/Views/Pages/Admin/CourseManager_Admin.jsp";

        User user = (User) session.getAttribute("user");

        //check whether user is a admin or not
        if (user == null || user.getRole().getId() != 1) {
            url = "/log-in?start=1";
        } else if (request.getParameter("start") != null) {

        } else {
            int page = 1;
            int maxPageItems = 5;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                maxPageItems = Integer.parseInt(request.getParameter("maxPageItems")); //number of items per a page
                request.setAttribute("maxPageItems", maxPageItems);
            } catch (Exception ex) {
            }

            String courseName = request.getParameter("nameForSearch");
            request.setAttribute("nameForSearch", courseName);

            String author = request.getParameter("authorForSearch");
            request.setAttribute("authorForSearch", author);

            String api_url = APIUtils.getBaseURLAPi() + "admin/course?page=" + page + "&limit=" + maxPageItems;

            if (courseName != null && !courseName.isEmpty()) {
                api_url = api_url + "&coursename=" + courseName;
            }
            if (author != null && !author.isEmpty()) {
                api_url = api_url + "&authorname=" + author;
            }

            //check status
            String status = request.getParameter("courseFor");
            request.setAttribute("courseFor", status);
            if (status != null) {
                if ("Public".equals(status)) {
                    api_url = api_url + "&status=" +"True";
                } else if ("Private".equals(status)) {
                    api_url = api_url + "&status=" + "False";
                }
            }

            //check blocked
            String blocked = request.getParameter("blockedStatus");
            request.setAttribute("blockedStatus", blocked);
            if (blocked != null && blocked.equals("Yes")) {
                 api_url = api_url + "&blocked=" + "True";
            } else if (blocked != null && blocked.equals("No")) {
                api_url = api_url + "&blocked=" + "False";
            }

            System.out.println("api " + api_url);
            String result = APIUtils.sendGetRequest(api_url, true);

            System.out.println(result);
            if (result != null) {
                ObjectMapper mapper = new ObjectMapper();
                EntityPagination<Course> coursePagination = mapper.readValue(result,  new TypeReference<EntityPagination<Course>>(){});
//                System.out.println(coursePagination);
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
