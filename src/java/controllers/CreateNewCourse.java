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
@WebServlet(name = "createNewCourse", urlPatterns = {"/create-course"})
public class CreateNewCourse extends HttpServlet {

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

        String url = "/Views/Pages/Course/CreateNewCourse.jsp";

        HttpSession session = request.getSession();

        //check whether user logined
        User user = (User) session.getAttribute("user");

        if (user == null) {
            url = "/Views/Pages/User/Login.jsp";
        } else {
            try {
                //if start =1, only open the page
                //start is null, process the requirement
                if (request.getParameter("start") == null) {
                    String name = request.getParameter("courseName");
                    String description = request.getParameter("description");
                    boolean status = false;

                    if ("public".equals(request.getParameter("status"))) {
                        status = true;
                    }

                    //check info
                    if (name.isEmpty() || description.isEmpty()) {
                        request.setAttribute("errorMessage", "Please fill all information!");

                    } else {

                        Course course = new Course(name, description, status, user);

                        //send to API
                        String api_url = APIUtils.getBaseURLAPi() + "course";

                        ObjectMapper mapper = new ObjectMapper();
                        String jsonRequest = mapper.writeValueAsString(course);

                        String result = APIUtils.sendPostRequest(api_url, jsonRequest);
//                        System.out.println("Create course: " + result);

                        if (result != null) {
                            course = mapper.readValue(result, Course.class);
                            request.setAttribute("course", course);
                        } else {
                            request.setAttribute("errorMessage", "Sorry! Can't create your course");
                        }
                    }
                }
            } catch (Exception ex) {

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
