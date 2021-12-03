/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Object.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.util.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

//import com.oreilly.servlet.MultipartRequest;
/**
 *
 * @author PhanSu
 */
@WebServlet(name = "UpdateInfor", urlPatterns = {"/update-info"})
@MultipartConfig
public class UpdateInfor extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/Views/Pages/User/UpdateInformation.jsp";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String nameupdate = "";
        String birth = "";
        String gender = "";
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (isMultipart) {
            try {
                //Create a factory for disk-based file items
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // Configure a repository (to ensure a secure temp location is used)
                ServletContext servletContext = this.getServletConfig().getServletContext();
                File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
                factory.setRepository(repository);
                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // Parse the request
                List<FileItem> items = upload.parseRequest(request);
                // Process the uploaded items
                Iterator<FileItem> iter = items.iterator();
                HashMap<String, String> fields = new HashMap<>();
                while (iter.hasNext()) {
                    FileItem item = iter.next();
                    if (item.isFormField()) {
                        String name = item.getFieldName();
                        String value = item.getString();
                        fields.put(name, value);
//                        System.out.println("test  " + name +value);
                    } else {
                        String filename = item.getName();
                        if (filename == null || filename.equals("")) {
                            break;
                        } else {
                            Path path = Paths.get(filename);
                            String storePath = servletContext.getRealPath("/uploads");
                            File uploadFile = new File(storePath + "/" + path.getFileName());
                            item.write(uploadFile);
                        }
                        fields.put("image", filename);
                    }
                }
                if (fields.get("nameupdate") != null && fields.get("gender") != null && fields.get("birthdate") != null) {
                    nameupdate = fields.get("nameupdate");
                    gender = fields.get("gender");
                    birth = fields.get("birthdate");
                    String image = fields.get("image");
                    Date birthEdit = Date.valueOf(birth);
                    
                    System.out.println("Image: " + image);
                    if (image == null) {
                        image = (String)user.getImage();
                    }
                    User userupdate = new User(nameupdate, gender, birthEdit, user.getEmail(), image, user.getRole());
                    //send http request to create new user
                    ObjectMapper mapper = new ObjectMapper();
                    String jsonRequest = mapper.writeValueAsString(userupdate);
                    String result = APIUtils.sendPutRequest("http://localhost:8081/user/" + user.getId(), jsonRequest);
                    if (result == null) {
                        request.setAttribute("alertMessage", "Sorry! Can't update your information!!!");
                    } else {
                        User usercurrent = mapper.readValue(result, User.class);
                        session.setAttribute("user", usercurrent);
                        request.setAttribute("alertMessage", "Updated your information.");
                        url = "/Views/Pages/User/UserInformation.jsp";
                        
                    }
                } else {
                    request.setAttribute("errorMessageUpdate", "Information is not enough!!! ");
                }
            } catch (FileUploadException fue) {
                request.setAttribute("errorMessage", "Error!");
            }
        }

//                FileItemIterator iter = upload.getItemIterator(request);
//                FileItemStream item = null;
//                String name = "";
//                InputStream stream = null;
//                HashMap<String, String> fields = new HashMap<>();
//                while (iter.hasNext()) {
//                    item = iter.next();
//                    name = item.getFieldName();
//                    stream = item.openStream();
//                    
////                    out.write("Form field " + name + ": "+ Streams.asString(stream) + "<br/>");
//                    if (item.isFormField()) {
//                        
////                        if(name.equals("nameupdate")){
////                            nameupdate = Streams.asString(stream);
////                        }
////                        if(name.equals("gender")){
////                            gender = Streams.asString(stream);
////                        }
////                        fields.put(name, stream);
////                          String value = Streams.asString(stream);
////                          System.out.print("Ket qua:" + name + " "+ value );
//                    } else {
////                        fields.put(item.getFieldName(), item.getName());
//                        name = item.getName();
////                        System.out.println("name==" + name);
//                        if (name != null && !"".equals(name)) {
//                            String fileName = new File(item.getName()).getName();
//                            File file = new File(getServletContext().getRealPath("/uploads/" + fileName));
//                            FileOutputStream fos = new FileOutputStream(file);
//                            long fileSize = Streams.copy(stream, fos, true);
////                            fields.put(name, fileName);
//                        }
//                    }
////                    Path tempFile = Files.createTempFile(UUID.randomUUID().toString(),UUID.randomUUID().toString());
////                    Files.copy(stream, tempFile, StandardCopyOption.REPLACE_EXISTING);
////                    String valuestream = new String(Files.readAllBytes(tempFile));
//                    
////                    out.write("Form field " + name + valuestream +"<br/>");
//                    fields.put(name, valuestream);
//                    out.write("Field " + fields.get("nameupdate") + fields.get("gender") +"<br/>");
//                    nameupdate = fields.get("nameupdate");
//                    gender = fields.get("gender");
//                }
//                if(!nameupdate.equals("")){
////                    nameupdate = fields.get("nameupdate");
////                    gender = fields.get("gender");
//        //                        String image = fields.get("file");
//
//        //                        Date birthEdit = Date.valueOf(birth);
//                    User userupdate = new User(nameupdate, gender, null, user.getEmail(), null);
//                    //send http request to create new user
//                    ObjectMapper mapper = new ObjectMapper();
//                    String jsonRequest = mapper.writeValueAsString(userupdate);
//                    String result = APIUtils.sendPutRequest("http://localhost:8082/user/" + user.getId(), jsonRequest);
////                    out.write("Ket qua:" + result);
//
//                } else {
//                    request.setAttribute("errorMessageUpdate", "The code is incorrect! ");
//                }
//                
////            } catch (FileUploadException fue) {  
////            }
//        }   
//        String checkUpdate = request.getParameter("start");
//        if (checkUpdate == null) {
//            try {
//                String name = (String) request.getParameter("nameupdate");
//                if (name == null) {
//                    request.setAttribute("errorMessageUpdate", "The code is incorrect name1111");
//                    name = "";
//                }
//                request.setAttribute("nameupdate", name);
//                
//                String email = (String) request.getParameter("emailupdate");
//                request.setAttribute("emailupdate", email);
////                if (email == null) {
////                    request.setAttribute("errorMessageUpdate", "The code is incorrect email");
////                }
//                String birth = request.getParameter("birthdate");
//                request.setAttribute("birthdate", birth);
//                if (birth == null) {
//                    birth = "";
//                }
//                request.setAttribute("birthdate", birth);
//                String gender = "";
//                String select[] = request.getParameterValues("gender");
//                if (select != null && select.length != 0) {
//                    gender = select[0];
//                }
//                String image = request.getParameter("file");
//                
////                email != null && name!=null && gender!= null && !email.isEmpty() && !name.isEmpty()&& !gender.isEmpty()
//                if (true) {
//
//                    Date birthEdit = Date.valueOf(birth);
//                    User userupdate = new User(name, gender, birthEdit, user.getEmail(), image);
//                    //send http request to create new user
//                    ObjectMapper mapper = new ObjectMapper();
//                    String jsonRequest = mapper.writeValueAsString(userupdate);
//                    String result = APIUtils.sendPutRequest("http://localhost:8082/user/" + user.getId(), jsonRequest);
//                    System.out.print("Ket qua:" + result);
//
//                } else {
//                    request.setAttribute("errorMessageUpdate", "The code is incorrect! ");
//                }
//            } catch (Exception ex) {
//                request.setAttribute("errorMessage", "*Can't sign up!");
//            }
//        }
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
        try {
            processRequest(request, response);
            //request.getRequestDispatcher("UpdateInformation.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UpdateInfor.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {

            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UpdateInfor.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    private static String convertInputStreamToString(InputStream inputStream) throws IOException {
        //convert
        return null;
    }
}
