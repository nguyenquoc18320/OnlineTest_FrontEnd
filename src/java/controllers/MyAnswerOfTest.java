package controllers;

import Object.Answer;
import Object.Question;
import Object.Test;
import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(name = "MyAnswerOfTest", urlPatterns = {"/my-answer-test"})
public class MyAnswerOfTest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/MyAnswerOfTest.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            url = "/log-in?start=1";
        } else {
            try {
                //get test
                Long testid = Long.parseLong(request.getParameter("testid"));
                int attempt = Integer.parseInt(request.getParameter("attempt"));

                String api_url = APIUtils.getBaseURLAPi() + "test/" + testid;

                ObjectMapper mapper = new ObjectMapper();

                String result = APIUtils.sendGetRequest(api_url, true);

                if (result != null) {
                    Test test = mapper.readValue(result, Test.class);
                    request.setAttribute("test", test);
                    
                    //get questions
                    api_url = APIUtils.getBaseURLAPi() + "/test-question/" + test.getId();
                    System.out.println("a:" + api_url);

                    result = APIUtils.sendGetRequest(api_url, true);

                    List<Question> questionList = mapper.readValue(result, new TypeReference<List<Question>>() {
                    });

                    request.setAttribute("questionList", questionList);

                    //get answers
                    api_url = APIUtils.getBaseURLAPi() + "test/answer?testid=" + testid
                            + "&userid=" + user.getId() + "&attempt=" + attempt;

                    result = APIUtils.sendGetRequest(api_url, true);
                    if (result != null) {
                        List<Answer> answerList = mapper.readValue(result, new TypeReference<List<Answer>>() {
                        });
                        request.setAttribute("answerList", answerList);
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
