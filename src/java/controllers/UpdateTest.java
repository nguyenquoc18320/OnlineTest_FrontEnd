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
@WebServlet(name = "UpdateTest", urlPatterns = {"/update-test"})
public class UpdateTest extends HttpServlet {

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

        String url = "/Views/Pages/Test/UpdateTest.jsp";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        ///tam
        String api_url = APIUtils.getBaseURLAPi();
        ObjectMapper mapper = new ObjectMapper();
        String checkSrart = request.getParameter("start");
        if (checkSrart!=null){
            try {
                String courseidupdate = request.getParameter("courseid");
                String courseupdate = APIUtils.sendGetRequest(api_url + "course/"+ courseidupdate, true);
                System.out.println("Result course: " + courseupdate);
                Course course = mapper.readValue(courseupdate, Course.class);
                String testidupdate = request.getParameter("testid");
                String resultTest = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi()+ "test/" + testidupdate, true);
                String resultListCourse = APIUtils.sendGetRequest( APIUtils.getBaseURLAPi() + "course-by-user/" + user.getId(), true);
                Test test = mapper.readValue(resultTest, Test.class);
                List<Course> courseList = mapper.readValue(resultListCourse, new TypeReference<List<Course>>() {
                });
                if (courseList != null) {
                    request.setAttribute("courseList", courseList);
                    request.setAttribute("Test", test);
                    request.setAttribute("CourseUpdate", course);
                }
            } catch (Exception ex) {
                request.setAttribute("errorMessage", "Can't load course!");
            }
        }
        else{
            String couresid = request.getParameter("listourse");
            String name = request.getParameter("testname");
            String description = request.getParameter("description");
            int duration = Integer.valueOf(request.getParameter("duration"));
            int attempt = Integer.valueOf(request.getParameter("attempt"));
            //get course                
            String result = APIUtils.sendGetRequest(api_url + "course/" + couresid, true);
            Course courseresult = mapper.readValue(result, Course.class);
            Test testupdate = new Test(name, description, duration, true, attempt, false, courseresult);
            String jsonRequest = mapper.writeValueAsString(testupdate);
            int testid = Integer.valueOf(request.getParameter("testid"));
            String resultcreate = APIUtils.sendPutRequest(api_url + "test/"+testid, jsonRequest);
            System.out.println("Update test: " + resultcreate);
            url = "list-test?start=1";
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
