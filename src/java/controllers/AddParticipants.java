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
@WebServlet(name = "AddParticipants", urlPatterns = {"/add-participants"})
public class AddParticipants extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/Course/AddParticipants.jsp";

        HttpSession session = request.getSession();

        //check whether user logined
        User user = (User) session.getAttribute("user");

        if (user == null) {
            url = "/Views/Pages/User/Login.jsp";
        } else {
            try {

            Long courseid = Long.parseLong(request.getParameter("courseid"));

            //send to API
            String api_url = APIUtils.getBaseURLAPi() + "course?userid=" + user.getId()
                    + "&courseid=" + courseid;

            String result = APIUtils.sendGetRequest(api_url, true);

            if (result != null) {
                Course course = new Course();
                ObjectMapper mapper = new ObjectMapper();
                course = mapper.readValue(result, Course.class);
                request.setAttribute("course", course);

                //add participants
                String emails = request.getParameter("email");
                request.setAttribute("email", emails);

//                    System.out.println("Emails: " + emails);
                if (emails != null && !emails.isEmpty()) {
                    String[] emailList = emails.split("\r\n");

                    api_url = APIUtils.getBaseURLAPi() + "join-course?courseid=" + courseid
                            +"&userid=" + user.getId();
                    System.out.println(api_url);

                    String jsonRequest = mapper.writeValueAsString(emailList);
                    System.out.println("json:: " + jsonRequest);
                    result = APIUtils.sendPutRequest(api_url, jsonRequest);
                    request.setAttribute("result", result);
                    
                    System.out.println("Join course: " + result);
                }

            } else {
                request.setAttribute("errorMessage", "Don't find the course!");
            }

            } catch (Exception ex) {
                url = "/manager-course-user";
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
