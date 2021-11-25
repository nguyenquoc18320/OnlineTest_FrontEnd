/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.Answer;
import Object.Course;
import Object.Question;
import Object.Test;
import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "AddQuestion", urlPatterns = {"/add-question"})
public class AddQuestion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "/Views/Pages/Test/AddQuestion.jsp";
//String url = "list-test?start=1";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");
//        Course course = (Course) session.getAttribute("Course");

        String api_url = APIUtils.getBaseURLAPi();
        ObjectMapper mapper = new ObjectMapper();

        String checkSrart = request.getParameter("start");
        if (checkSrart != null) {
            String courseidupdate = request.getParameter("courseid");
            String courseupdate = APIUtils.sendGetRequest(api_url + "course/" + courseidupdate, true);
            System.out.println("Result course: " + courseupdate);
            Course course = mapper.readValue(courseupdate, Course.class);
            request.setAttribute("Course", course);
            String testidQ = request.getParameter("testid");
            if (testidQ == null) {
                url = "list-test?start=1";
            } else {
                String resultTest = APIUtils.sendGetRequest(api_url + "test/" + testidQ, true);
                //String resultCourse = APIUtils.sendGetRequest("http://localhost:8082/course/" + courseQ, true);
                Test test1 = mapper.readValue(resultTest, Test.class);
//                Course course = mapper.readValue(resultCourse, Course.class);
//                System.out.println("Result test we: " + test1);
                String resultListQuestion = APIUtils.sendGetRequest(api_url + "/test-question/" + testidQ, true);
                List<Question> listQuestion = mapper.readValue(resultListQuestion, new TypeReference<List<Question>>() {
                });
                if (test1 != null) {
                    request.setAttribute("Test", test1);
                    request.setAttribute("listQuestion", listQuestion);
                    System.out.println("Result list: " + listQuestion);
                    request.setAttribute("totalQuestion", listQuestion.size());
                    System.out.println("Result total: " + listQuestion.size());
                    if (listQuestion == null) {
                        request.setAttribute("errorMessage", "You need add question!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Error!!");
                }
            }

        } else {
            System.out.println("error start: ");
        }

//        try {
        if (checkSrart == null) {
            String testid = request.getParameter("testid");
//                System.out.println("Result1: " + testidupdate);
            String resultTest = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi() + "test/" + testid, true);
            Test test = mapper.readValue(resultTest, Test.class);
            System.out.println("test 2: " + test);
//                List<Answer> answers = new ArrayList<Answer>();
            int number = 1;
            int totalQuestion = 0;
            while (number > 0) {
                System.out.println("number: " + number);
                String numberQuestion = request.getParameter("intput_question_number_" + number);
                if (numberQuestion != null) {
                    int numberQuestion2 = Integer.valueOf(numberQuestion);
                    System.out.println("number: " + numberQuestion);
                    String content = request.getParameter("contentQuestion" + number);
                    String a = request.getParameter("a_question" + number);
                    String b = request.getParameter("b_question" + number);
                    String c = request.getParameter("C_question" + number);
                    String d = request.getParameter("D_question" + number);
                    String e = request.getParameter("E_question" + number);
                    String f = request.getParameter("F_question" + number);
                    String g = request.getParameter("G_question" + number);
                    String h = request.getParameter("H_question" + number);
                    String i = request.getParameter("I_question" + number);
                    String j = request.getParameter("J_question" + number);
                    String correctquestion = request.getParameter("correctQ" + number);

                    Question question = new Question(numberQuestion2, correctquestion, content, a, b, c, d, e, f, g, h, i, j, false, test);
                    String jsonRequest = mapper.writeValueAsString(question);
                    // Check Question exist
                    String checkQuestionExist = APIUtils.sendGetRequest(APIUtils.getBaseURLAPi() + "question-exist/" + test.getId() + "/" + numberQuestion2, true);
                    if (checkQuestionExist == null) {// add new question
                        String resultcreate = APIUtils.sendPostRequest(APIUtils.getBaseURLAPi() + "question", jsonRequest);
                        System.out.println("Create Question: " + resultcreate);
                        if (resultcreate == null) {
                            request.setAttribute("errorMessage", "Sorry! Can't create your question");
                        }
                    } else { // update Quetion
                        String resultupdate = APIUtils.sendPutRequest(APIUtils.getBaseURLAPi() + "question", jsonRequest);
                        System.out.println("update Question: " + resultupdate);
                        if (resultupdate == null) {
                            request.setAttribute("errorMessage", "Sorry! Can't update your question");
                        }
                    }
                    totalQuestion = totalQuestion + 1;
                    number = number + 1;
                } else {
                    number = -1;
                }

            }
            System.out.println("Tong: " + totalQuestion);
            //delete question
            String resultListQuestion = APIUtils.sendGetRequest(api_url + "/test-question/" + testid, true);
            List<Question> listQuestion = mapper.readValue(resultListQuestion, new TypeReference<List<Question>>() {
            });
            for (int i = listQuestion.size(); i > totalQuestion; i--) {
                String resultdelete = APIUtils.sendPutRequest(APIUtils.getBaseURLAPi() + "delete-question/"+testid + "/" + i, "");
                System.out.println("Delete Question: " + resultdelete);
                if (resultdelete == null) {
                    request.setAttribute("errorMessage", "Sorry! Can't delete your question");
                    break;
                }
            }
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
