/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

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
@WebServlet(name = "ManagerUser_Admin", urlPatterns = {"/manage-user"})
public class ManagerUser_Admin extends HttpServlet {

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

        String url = "/Views/Pages/Admin/UserManager_Admin.jsp";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String api_url = APIUtils.getBaseURLAPi();
        ObjectMapper mapper = new ObjectMapper();
        //check login
        if (user == null || user.getRole().getId() != 1) {
            url = "/log-in?start=1";
        }
        else{
            String checkSrart = request.getParameter("start");
            
            if(checkSrart==null){
                //list user

                String resultList = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi() + "listuser", true);
                List<User> userList = mapper.readValue(resultList, new TypeReference<List<User>>() {
                });
                System.out.println("List user result: " + userList);
                if (userList != null) {
                    request.setAttribute("userList", userList);
                }
            }
            if(checkSrart!=null){
                
                boolean status2 = true;
                String type = request.getParameter("type");
                String status = request.getParameter("status");
                if(status.equals("0")){
                    if(type.equals("0")){
                        String resultList = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi() + "listuser", true);
                        List<User> userList = mapper.readValue(resultList, new TypeReference<List<User>>() {
                        });
                        System.out.println("List user result: " + userList);
                        if (userList != null) {
                            request.setAttribute("userList", userList);
                        }
                    }else{
                        String resultList = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi() + "listuser/"+type, true);
                        List<User> userList = mapper.readValue(resultList, new TypeReference<List<User>>() {
                        });
                        System.out.println("List user result2: " + userList);
                        if (userList != null) {
                            request.setAttribute("userList", userList);
                            request.setAttribute("type", type);
                            request.setAttribute("status", status);
                        }
                    }
                }else{
                    if(status.equals("1"))
                        status2 = false;
                    if(status.equals("2")){
                        status2 = true;
                    }
                        String resultList = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi() + "listuser/"+type+"/"+status2, true);
                        List<User> userList = mapper.readValue(resultList, new TypeReference<List<User>>() {
                        });
                        System.out.println("List user result3: " + userList);
                        if (userList != null) {
                            request.setAttribute("userList", userList);
                            request.setAttribute("type", type);
                            request.setAttribute("status", status);
                        }
                }
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
