/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Course;
import Object.Test;
import Object.TestResult;
import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "TestResults", urlPatterns = {"/test-result"})
public class TestResults extends HttpServlet {

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

        String url = "/Views/Pages/Test/TestResult.jsp";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        ///tam
        String api_url = APIUtils.getBaseURLAPi();
        ObjectMapper mapper = new ObjectMapper();
        String checkSrart = request.getParameter("start");
        System.out.println("start: " + checkSrart);
        if(checkSrart.equals("-1")){
            String courseidupdate = request.getParameter("courseid");
                 System.out.println("CourseID: " + courseidupdate);
                String courseupdate = APIUtils.sendGetRequest(api_url + "course/"+ courseidupdate, true);
                System.out.println("Result course: " + courseupdate);
                Course course = mapper.readValue(courseupdate, Course.class);
                
                
                String resultListCourse = APIUtils.sendGetRequest( APIUtils.getBaseURLAPi() + "course-by-user/" + user.getId(), true);
                
                List<Course> courseList = mapper.readValue(resultListCourse, new TypeReference<List<Course>>() {
                });
                 System.out.println("List course: " + courseList);
                //list test
                String resultListTest = APIUtils.sendGetRequest( APIUtils.getBaseURLAPi() + "test-by-course/" + courseidupdate, true);
                List<Test> testList = mapper.readValue(resultListTest, new TypeReference<List<Test>>() {
                });   
                System.out.println("List tes: " + resultListTest);
                //list result
                String resultListResult = APIUtils.sendGetRequest( APIUtils.getBaseURLAPi() + "test-result/" + testList.get(0).getId(), true);
                System.out.println("List: " + resultListResult);
                List<TestResult> resultLR = mapper.readValue(resultListResult, new TypeReference<List<TestResult>>() {
                });
                System.out.println("List test result: " + resultLR);
                if (courseList != null) {
                    request.setAttribute("courseList", courseList);
                    request.setAttribute("TestCurrent", testList.get(0));
                    request.setAttribute("CourseCurrent", course);
                    System.out.println("Course: " + course); 
                    request.setAttribute("testList", testList);
                    request.setAttribute("testResultList", resultLR);
                }
        }
        if (checkSrart.equals("1")){
//            try {
                String courseidupdate = request.getParameter("courseid");
                 System.out.println("CourseID: " + courseidupdate);
                String courseupdate = APIUtils.sendGetRequest(api_url + "course/"+ courseidupdate, true);
                System.out.println("Result course: " + courseupdate);
                Course course = mapper.readValue(courseupdate, Course.class);
                String testidupdate = request.getParameter("testid");
                String resultTest = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi()+ "test/" + testidupdate, true);
                String resultListCourse = APIUtils.sendGetRequest( APIUtils.getBaseURLAPi() + "course-by-user/" + user.getId(), true);
                Test test = mapper.readValue(resultTest, Test.class);
                List<Course> courseList = mapper.readValue(resultListCourse, new TypeReference<List<Course>>() {
                });
                 System.out.println("List course: " + courseList);
                //list test
                String resultListTest = APIUtils.sendGetRequest( APIUtils.getBaseURLAPi() + "test-by-course/" + courseidupdate, true);
                List<Test> testList = mapper.readValue(resultListTest, new TypeReference<List<Test>>() {
                });   
                System.out.println("List tes: " + resultListTest);
                //list result
                String resultListResult = APIUtils.sendGetRequest( APIUtils.getBaseURLAPi() + "test-result/" + testidupdate, true);
                System.out.println("List: " + resultListResult);
                List<TestResult> resultLR = mapper.readValue(resultListResult, new TypeReference<List<TestResult>>() {
                });
                System.out.println("List test result: " + resultLR);
                if (courseList != null) {
                    request.setAttribute("courseList", courseList);
                    request.setAttribute("TestCurrent", test);
                    request.setAttribute("CourseCurrent", course);
                    System.out.println("Course: " + course); 
                    request.setAttribute("testList", testList);
                    request.setAttribute("testResultList", resultLR);
                }
//            } catch (Exception ex) {
//                request.setAttribute("errorMessage", "Can't load result!");
//            }
        }
        if (checkSrart==null){
            try{
                
            }catch (Exception ex) {
                request.setAttribute("errorMessage", "Can't Update Test !");
            }
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
