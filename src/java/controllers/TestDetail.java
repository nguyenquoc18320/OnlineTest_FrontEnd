/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Test;
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
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@WebServlet(name = "TestDetail", urlPatterns = {"/test-detail"})
public class TestDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/TestDetail.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            url = "/log-in?start=1";
        } else if (user.getRole().getId() == 1) {//not user role
            url = "/manager-course-admin";
        } else {

            try {
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

                //get test result
                api_url = APIUtils.getBaseURLAPi() + "test/best-result?testid=" + testid
                        + "&userid=" + user.getId();

                result = APIUtils.sendGetRequest(api_url, true);

                if (result != null) {
                    JSONParser parser = new JSONParser();
                    JSONObject object = (JSONObject) parser.parse(result);

                    request.setAttribute("result", object);
                }

                //check to continue test
                api_url = APIUtils.getBaseURLAPi() + "test/attending-result?testid=" + testid
                        + "&userid=" + user.getId();

                result = APIUtils.sendGetRequest(api_url, true);
                
                if (result != null) {
                    System.out.println("test: " + result);
                    JSONParser parser = new JSONParser();
                    JSONObject object = (JSONObject) parser.parse(result);
//                    System.out.println("test: " + Float.parseFloat((String) object.get("score")));
                    if ((Double)object.get("score") == -1.0) {
                        request.setAttribute("continueStatus", true);
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
