package controllers.Admin;

import Object.Course;
import Object.EntityPagination;
import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import controllers.APIUtils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UserCourse_Admin", urlPatterns = {"/user-course-admin"})
public class UserCourse_Admin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/Admin/UserCourse_Admin.jsp";

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        try {
            //check whether logining
            if (user == null || user.getRole().getId() != 1) {
                url = "/log-in?start=1";
            } else {
                String courseid = (String) request.getParameter("courseid");
                String userid = (String) request.getParameter("userid");
                request.setAttribute("userid", userid);

                //get author
                String api_url = APIUtils.getBaseURLAPi() + "user?userid=" + userid;
                
                String author = APIUtils.sendGetRequest(api_url, true);
                 ObjectMapper mapper = new ObjectMapper();
                if(author!=null){
                    User authorE = mapper.readValue(author, User.class);
                    request.setAttribute("author", authorE);
                }
                
                //get page and limit
                String page = (String) request.getParameter("page");
                String maxPageItems = (String) request.getParameter("maxPageItems");

                if (page == null) {
                    page = "1";
                }

                if (maxPageItems == null) {
                    maxPageItems = "5";
                }

                //api url
                api_url = APIUtils.getBaseURLAPi() + "course/search?userid=" + userid
                        + "&page=" + page + "&limit=" + maxPageItems;

                //name for searching
                String courseName = request.getParameter("nameForSearch");
                if (courseName != null) {
                    request.setAttribute("nameForSearch", courseName);
                    api_url += "&coursename=" + courseName;
                }

                //check status
                String status = request.getParameter("courseFor");
                request.setAttribute("courseFor", status);
                if (status != null) {
                    if ("Public".equals(status)) {
                        api_url = api_url + "&status=" + "True";
                    } else if ("Private".equals(status)) {
                        api_url = api_url + "&status=" + "False";
                    }
                }

                //check blocked
                String blocked = request.getParameter("blockedStatus");
                request.setAttribute("blockedStatus", blocked);
                if (blocked != null && blocked.equals("Yes")) {
                    api_url = api_url + "&blocked=" + "True";
                } else if (blocked != null && blocked.equals("No")) {
                    api_url = api_url + "&blocked=" + "False";
                }

                //send to api and get result
                String result = APIUtils.sendGetRequest(api_url, true);

                if (result != null) {
                   
                    EntityPagination<Course> coursePagination = mapper.readValue(result, new TypeReference<EntityPagination<Course>>() {
                    });
                    request.setAttribute("coursePagination", coursePagination);
                }
                
                /*
                FROM BlOCK FUNCTION
                */
                String blockMessage = (String)request.getAttribute("blockedMessage");
                if(blockMessage != null && !blockMessage.isEmpty()){
                    request.setAttribute("blockedMessage", blockMessage);
                }

            }
        } catch (Exception ex) {

        }
        getServletContext()
                .getRequestDispatcher(url).forward(request, response);
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
