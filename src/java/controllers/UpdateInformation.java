/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.User;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.util.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 *
 * @author PhanSu
 */
//@WebServlet(name = "Update, urlPatterns = {"/upda_d"})
public class UpdateInformation extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/UpdateInformation.jsp";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");
//        //upload image
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        if (isMultipart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            try {
                List items = upload.parseRequest((RequestContext) request);
                if(true){
                    Iterator iterator = items.iterator();
                    while (iterator.hasNext()) {
                        FileItem item = (FileItem) iterator.next();
                        if (!item.isFormField()) {
                            String fileName = item.getName();

                            String root = getServletContext().getRealPath("/");
                            File path = new File(root + "/fileuploads");
                            if (!path.exists()) {
                                boolean status = path.mkdirs();
                            }

                            File uploadedFile = new File(path + "/" + fileName);
                            item.write(uploadedFile);
                        }
                    }
                }
            } catch (Exception e) {}
//        // Create a factory for disk-based file items
//        DiskFileItemFactory factory = new DiskFileItemFactory();
//        // Configure a repository (to ensure a secure temp location is used)
//        ServletContext servletContext = this.getServletConfig().getServletContext();
//        File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
//        factory.setRepository(repository);
//        // Create a new file upload handler
//        ServletFileUpload upload = new ServletFileUpload(factory);
//        // Parse the request
//        List<FileItem> items = upload.parseRequest(request);
//        // Process the uploaded items
//        Iterator<FileItem> iter = items.iterator();
//        HashMap<String, String> files = new HashMap<>();
//        while (iter.hasNext()) {
//            FileItem item = iter.next();
//
//            if (item.isFormField()) {
//                String nameimage = item.getFieldName();
//                String valueimage = item.getString();
//                System.out.print("name:" + nameimage);
//                System.out.print("value:" + valueimage);
//            } else {
//
//            }
//        }
//        if (!ServletFileUpload.isMultipartContent(request)) {
//            out.println("Nothing to upload");
//            return;
//        }
//
//        FileItemFactory itemfactory = new DiskFileItemFactory();
//        ServletFileUpload upload = new ServletFileUpload(itemfactory);
//        
//        try {
//            
//            List items = upload.parseRequest(request);
//            for (FileItem item : items) {
//
//                String contentType = item.getContentType();
//                if (!contentType.equals("image/png")) {
//                    out.println("only png format image files supported");
//                    continue;
//                }
//                File uploadDir = new File("F:\\UploadedFiles");
//                File file = File.createTempFile("img", ".png", uploadDir);
//                item.write(file);
//
//                out.println("File Saved Successfully");
//            }
//        } catch (FileUploadException e) {
//
//            out.println("upload fail");
//        }

                String checkUpdate = request.getParameter("start");
                if (checkUpdate
                        == null) {
                    try {
                        String name = (String) request.getParameter("nameupdate");
                        request.setAttribute("namupdate", name);
                        if (name == null) {
                            request.setAttribute("errorMessageUpdate", "The code is incorrect name");
                            name = "";
                        }
                        String email = (String) request.getParameter("emailupdate");
                        request.setAttribute("emailupdate", email);
                        if (email == null) {
                            request.setAttribute("errorMessageUpdate", "The code is incorrect email");
                        }

                        String birth = request.getParameter("birthdate");
                        request.setAttribute("birthdate", birth);
                        if (birth == null) {
                            birth = "";
                        }
                        request.setAttribute("birthdate", birth);
                        String gender = "";
                        String select[] = request.getParameterValues("gender");
                        if (select != null && select.length != 0) {
                            gender = select[0];
                        }

                        String imageS = request.getParameter("imageupdate");
                        byte[] image = imageS.getBytes();

//                email != null && name!=null && gender!= null && !email.isEmpty() && !name.isEmpty()&& !gender.isEmpty()
                        if (true) {

                            Date birthEdit = Date.valueOf(birth);
                            User userupdate = new User(name, gender, birthEdit, user.getEmail(), null,user.getRole());
                            //send http request to create new user
                            ObjectMapper mapper = new ObjectMapper();
                            String jsonRequest = mapper.writeValueAsString(userupdate);
                            String result = APIUtils.sendPutRequest("http://localhost:8081/user/" + user.getId(), jsonRequest);
                            System.out.print("Ket qua:" + result);

                        } else {
                            request.setAttribute("errorMessageUpdate", "The code is incorrect2!   sai ");
                        }
                    } catch (Exception ex) {
                        request.setAttribute("errorMessage", "*Can't sign up!");
                    }
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
    }
}
