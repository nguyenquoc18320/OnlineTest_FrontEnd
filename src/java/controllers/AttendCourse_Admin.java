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
@WebServlet(name = "AttendCourse_Admin", urlPatterns = {"/user-attend-course-Admin"})
public class AttendCourse_Admin extends HttpServlet {

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
        String url = "/Views/Pages/Admin/UserAttendCourse_Admin.jsp";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String userid = request.getParameter("userid");
        if (user == null) {
            url = "/log-in?start=1";
        } else if (user.getRole().getId() != 1) {//not user role
            url = "/log-in?start=1";
        } else {

            int page = 1;
            int maxPageItems = 6;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                maxPageItems = Integer.parseInt(request.getParameter("maxPageItems")); //number of items per a page
                request.setAttribute("maxPageItems", maxPageItems);
            } catch (Exception ex) {
            }
            
            //get list user
            ObjectMapper mapper = new ObjectMapper();
            String resultList = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi() + "listuser/2", true);// id: 2(user)
            List<User> userList = mapper.readValue(resultList, new TypeReference<List<User>>() {
            });
//            System.out.println("List user: " + userList);
            if (userList != null) {
                request.setAttribute("userList", userList);
            }
            String checkStart = request.getParameter("start");
            try{
                if(checkStart==null){
                    //get course list user attended
                    String api_url = APIUtils.getBaseURLAPi() + "join-course/get-course-list-admin?userid=" + userid
                            + "&page=" + page + "&limit=5" + maxPageItems;

                    String result = APIUtils.sendGetRequest(api_url, true);

                    if (result != null) {

                        EntityPagination<Course> coursePagination = mapper.readValue(result, new TypeReference<EntityPagination<Course>>() {
                        });
                        request.setAttribute("coursePagination", coursePagination);
                        request.setAttribute("usersearch", userid);
                    }
                }
                if(checkStart!=null){
                    String userid_cbb = request.getParameter("userid");
                    String api_url = APIUtils.getBaseURLAPi() + "join-course/get-course-list-admin?userid=" + userid_cbb
                            + "&page=" + page + "&limit=5" + maxPageItems;

                    String result = APIUtils.sendGetRequest(api_url, true);

                    if (result != null) {

                        EntityPagination<Course> coursePagination = mapper.readValue(result, new TypeReference<EntityPagination<Course>>() {
                        });
                        request.setAttribute("coursePagination", coursePagination);
                    }
                }
            }catch (Exception ex) {
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
