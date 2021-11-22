/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Course;
import Object.Test;
import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "ListTestOfCourse", urlPatterns = {"/list-test"})
public class ListTestOfCourse extends HttpServlet {

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
        
        String url = "/Views/Pages/Test/ListTestOfCourse.jsp";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");
        
        ///Tempt 
        String api_url = APIUtils.getBaseURLAPi();            
        String resultcourse = APIUtils.sendGetRequest(api_url + "course/1", true);
//        System.out.println("Result: " + resultcourse);
        ObjectMapper mapper = new ObjectMapper();
        Course course = mapper.readValue(resultcourse, Course.class);
        session.setAttribute("Course", course);
        try {
            //check whether email exits
            String result = APIUtils.sendGetRequest("http://localhost:8081/test-course/" + course.getId(), true);
//            System.out.println("Result2: " + result);
//            ObjectMapper mapper = new ObjectMapper();
            List<Test> testList = mapper.readValue(result, new TypeReference<List<Test>>() {
            });
            
            if (testList != null) {
                request.setAttribute("testList", testList);
//                System.out.println("Result listTest: " + testList);
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);

        } catch (Exception ex) {
//            request.setAttribute("errorMessage", "Can't load course!");
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
