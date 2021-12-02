/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Course;
import Object.EntityPagination;
import Object.Test;
import Object.TestResult;
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

@WebServlet(name = "MyTestResults", urlPatterns = {"/my-test-results"})
public class MyTestResults extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/MyResulTest.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            url = "/log-in?start=1";
        } else if (user.getRole().getId() != 2) {//not user role
            url = "/manager-course-admin";
        } else {
//            try {
                Long testid = Long.parseLong(request.getParameter("testid"));

                //get test
                String api_url = APIUtils.getBaseURLAPi() + "test/attend?testid="
                        + testid + "&userid=" + user.getId();

                ObjectMapper mapper = new ObjectMapper();

                String result = APIUtils.sendGetRequest(api_url, true);

                Test test;
                if (result != null) {
                    test = mapper.readValue(result, Test.class);
                    request.setAttribute("test", test);
                }

                //get result
                int page = 1;
                int maxPageItems = 5;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    maxPageItems = Integer.parseInt(request.getParameter("maxPageItems")); //number of items per a page
                    request.setAttribute("maxPageItems", maxPageItems);
                } catch (Exception ex) {
                }
                
                request.setAttribute("maxPageItems", maxPageItems);

                String url_api = APIUtils.getBaseURLAPi() + "test/results?testid=" + testid
                        + "&userid=" + user.getId() + "&page=" + page + "&limit=" + maxPageItems; 

                result = APIUtils.sendGetRequest(url_api, true);
                if (result != null) {
                    EntityPagination<TestResult> resultPagination = mapper.readValue(result, new TypeReference<EntityPagination<TestResult>>() {
                    });
                    request.setAttribute("resultPagination", resultPagination);
                }

//            } catch (Exception ex) {
//
//            }
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
