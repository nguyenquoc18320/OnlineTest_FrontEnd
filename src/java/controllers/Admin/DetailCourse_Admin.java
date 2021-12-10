package controllers.Admin;

import Object.Course;
import Object.EntityPagination;
import Object.Test;
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


@WebServlet(name = "DetailCourse_Admin", urlPatterns = {"/detail-course-admin"})
public class DetailCourse_Admin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
         String url = "/Views/Pages/Admin/DetailCourse_Admin.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole().getId() != 1  ) {
            url = "/log-in?start=1";
        } else {
            try {
                //get course
                Long courseid = Long.parseLong(request.getParameter("courseid"));

                String api_url = APIUtils.getBaseURLAPi() + "admin?courseid=" + courseid;

                Course course = new Course();
                ObjectMapper mapper = new ObjectMapper();
                String jsonRequest = mapper.writeValueAsString(course);

                String result = APIUtils.sendGetRequest(api_url, true);

                if (result != null) {
                    course = mapper.readValue(result, Course.class);
                    request.setAttribute("course", course);
                }

                //get tests
                int page = 1;
                int maxPageItems = 6;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    maxPageItems = Integer.parseInt(request.getParameter("maxPageItems")); //number of items per a page
                    request.setAttribute("maxPageItems", maxPageItems);
                } catch (Exception ex) {
                }

                //get tests
                api_url = APIUtils.getBaseURLAPi() + "test/list?courseid=" + courseid
                        + "&page=" + page + "&limit=" + maxPageItems;

                result = APIUtils.sendGetRequest(api_url, true);
                
                if (result != null) {
                EntityPagination<Test> testPagination = mapper.readValue(result, new TypeReference<EntityPagination<Test>>() {
                });
                request.setAttribute("testPagination", testPagination);
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
