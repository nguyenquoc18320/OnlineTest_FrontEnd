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
@WebServlet(name = "CreateTest", urlPatterns = {"/create-test"})
public class CreateTest extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "/Views/Pages/Test/CreateTest.jsp";
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
                String result = APIUtils.sendGetRequest(api_url+"course-by-user/" + user.getId(), true);
                List<Course> courseList = mapper.readValue(result, new TypeReference<List<Course>>() {
                });
                if (courseList != null) {
                    request.setAttribute("courseList", courseList);
                    request.setAttribute("CourseCurrent", course);
                }
            } catch (Exception ex) {
                request.setAttribute("errorMessage", "Can't load list course!");
            }
        }
        if (checkSrart==null){
            try {
                //if start =1, only open the page
                //start is null, process the requirement
                if (request.getAttribute("start") == null) {
                    String couresid = request.getParameter("listourse");
                    String name = request.getParameter("testname");
                    String description = request.getParameter("description");
                    int duration = Integer.valueOf(request.getParameter("duration"));
                    int attempt = Integer.valueOf(request.getParameter("attempt"));
                    //get course                
                    String result = APIUtils.sendGetRequest(api_url + "course/"+couresid, true);
                    System.out.println("Course ID: " + couresid);
                    Course courseresult = mapper.readValue(result, Course.class);
                    Test test = new Test(name, description, duration, true, attempt, false, courseresult);

                    //create
                    String jsonRequest = mapper.writeValueAsString(test);

                    String resultcreate = APIUtils.sendPostRequest(api_url+ "test", jsonRequest);
                    System.out.println("Create test: " + resultcreate);

                    if (resultcreate == null) {
                        request.setAttribute("errorMessage", "Sorry! Can't create your test");
                    }else{
                       Test testcurrent = mapper.readValue(resultcreate, Test.class);
                        url = "add-question?courseid="+courseresult.getId()+"&testid="+testcurrent.getId()+"&start=1";
                    }
                }
            } catch (Exception ex) {
                request.setAttribute("errorMessage", "Sorry! Can't create your test");
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
                dispatcher.forward(request, response);
//        getServletContext().getRequestDispatcher(url).forward(request, response);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
