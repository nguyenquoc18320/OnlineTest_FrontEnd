/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Question;
import Object.Test;
import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet(name = "ContinueTest", urlPatterns = {"/continue-test"})
public class ContinueTest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/AttendTest.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            url = "/log-in?start=1";
        } else if (user.getRole().getId() != 2) {//not user role
            url = "/manager-course-admin";
        } else {
            try {
                //get test
                Long testid = Long.parseLong(request.getParameter("testid"));

                String api_url = APIUtils.getBaseURLAPi() + "test/attend?testid=" + testid
                        + "&userid=" + user.getId();

                ObjectMapper mapper = new ObjectMapper();

                String result = APIUtils.sendGetRequest(api_url, true);

                if (result != null) {
                    Test test = mapper.readValue(result, Test.class);
                    request.setAttribute("test", test);

                    //get test result, with endtime
                    api_url = APIUtils.getBaseURLAPi() + "/test/attending-result?testid=" + test.getId()
                            + "&userid=" + user.getId();
                    result = APIUtils.sendGetRequest(api_url, true);
                    if (result != null) {
                        JSONParser parser = new JSONParser();
                        JSONObject object = (JSONObject) parser.parse(result);
                        request.setAttribute("result", object);

                        //get questions
                        api_url = APIUtils.getBaseURLAPi() + "/question/attending-test?testid=" + test.getId()
                                + "&userid=" + user.getId();

                        result = APIUtils.sendGetRequest(api_url, true);

                        List<Question> questionList = mapper.readValue(result, new TypeReference<List<Question>>() {
                        });

                        request.setAttribute("questionList", questionList);

                        //get answers
                        api_url = APIUtils.getBaseURLAPi() + "answer/attending-test?testid=" + testid
                                + "&userid=" + user.getId();

                        result = APIUtils.sendGetRequest(api_url, true);

                        if (result != null) {
                            List<String> characters = Arrays.asList(new String[]{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"});
                            String[][] answerList = mapper.readValue(result, new TypeReference<String[][]>() {
                            });

                            int[][] anss = new int[answerList.length][2];
                            for (int i = 0; i < answerList.length; i++) {
                                anss[i][0] = Integer.parseInt(answerList[i][0]);
                                anss[i][1] = characters.indexOf(answerList[i][1]) + 1;
                            }
                            request.setAttribute("answerList", anss);
                        }
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
