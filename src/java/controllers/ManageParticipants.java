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
import java.util.List;
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
@WebServlet(name = "ManageParticipants", urlPatterns = {"/manage-participants"})
public class ManageParticipants extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/Course/ParticipantManager.jsp";

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        //check whether logining
        if (user == null) {
            url = "/log-in?start=1";
//            System.out.println("Not found user");
        } else {
            try {
                Long courseid = Long.parseLong(request.getParameter("courseid"));

                //send to API
                String api_url = APIUtils.getBaseURLAPi() + "course?userid=" + user.getId()
                        + "&courseid=" + courseid;

                Course course = new Course();
                ObjectMapper mapper = new ObjectMapper();
                String jsonRequest = mapper.writeValueAsString(course);

                String result = APIUtils.sendGetRequest(api_url, true);
                System.out.println("Create course: " + result);

                if (result != null) {
                    course = mapper.readValue(result, Course.class);
                    request.setAttribute("course", course);
                } else {
                    request.setAttribute("errorMessage", "Don't find the course!");
                }

                //get participants
                int page = 1;

                int maxPageItems = 5;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    maxPageItems = Integer.parseInt(request.getParameter("maxPageItems")); //number of items per a page
                    request.setAttribute("maxPageItems", maxPageItems);
                } catch (Exception ex) {
                }

                api_url = APIUtils.getBaseURLAPi() + "join-course/get-list?userid=" + user.getId()
                        + "&courseid=" + courseid + "&page=" + page + "&limit=" + maxPageItems;

                String searchName = request.getParameter("searchName");
                if(searchName !=null){
                    api_url += "&name=" + searchName;
                    request.setAttribute("searchName", searchName);
                }

                result = APIUtils.sendGetRequest(api_url, true);
                System.out.println(result);

                if (result != null) {
                    EntityPagination<User> participantPagination = mapper.readValue(result, new TypeReference<EntityPagination<User>>() {
                    });
                    request.setAttribute("participantPagination", participantPagination);
                }

            } catch (Exception ex) {
                request.setAttribute("errorMessage", "Don't find the course!");
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
