<%-- 
    Document   : UpdateInformation
    Created on : Oct 30, 2021, 8:05:19 AM
    Author     : PhanSu
--%>
<%@page import="Object.User"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/su/updateinfor.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <title>Update Information</title>
    </head>
    <body>
        <div class="container">         			
            <div id="container_demo" >
            <div id = "header">
                <img id = "logo" src="Views/CSS/images/logo1.png" alt="Logo">
            </div>
                
                <div id="wrapper">
                    <div id="register" class="animate form">
                        <form  action="update-info" autocomplete="on" method = "POST" enctype="multipart/form-data">
                            <h1> Update Information </h1> 
                            <div id="form-right">
                                <p> 
                                    <label for="usernamesignup" class="uname" data-icon="u">Your name</label>
                                    <input id="nameupdate" name="nameupdate" required="required" type="text" value="<c:out value="${user.getName()}"/>"/>
                                </p>
                                <p> 
                                    <label for="emailsignup" class="youmail" data-icon="e" > Your email</label>
                                    <input id="emailupdate" name="emailupdate" required="required" type="email" value ="<c:out value="${user.getEmail()}"/>" disabled/>
                                </p>
                                <p> 
                                    <label for="passwordsignup" class="youpasswd" data-icon="p">Your birthday </label>
                                    <input id="birthupdate" name="birthdate" type="date" required="required" value="<c:out value="${user.getDateOfBirth()}"/>" />
                                                                      
                                </p>
                                
                                <p class="topcheckbox">
                                    <label class="youpasswd" data-icon="p">Your gender </label><br>
                                </p>
                                <p class="checkboxupdate">                                    
                                    <input type="checkbox" id="myCheck" name="gender" alt="<c:out value="${user.getGender()}"/>" value="Male" />
                                    <label for="gender1"> Male</label>
                                    <input type="checkbox" id="myCheck2" name="gender" value="Female" style="margin-left: 40px;">
                                    <label for="gender1"> Female</label><br>                                    
                                    <script type="text/javascript">
                                        window.onload = function() {
                                            var genfermale = document.getElementById("myCheck");
                                            var genferfemale = document.getElementById("myCheck2");
                                            
                                            var gender = document.getElementById("myCheck");
                                            if( gender.alt === "Male")
                                            { 	
                                                genfermale.checked = true;
                                                genferfemale.checked = false;
                                            }
                                            else {
                                                genfermale.checked = false;
                                                genferfemale.checked = true;
                                            } 
                                    }
                                    </script>
                                    <!--Change check--> 
                                    <script>
                                        $(document).ready(function(){
                                            $('input:checkbox').click(function() {
                                                $('input:checkbox').not(this).prop('checked', false);
                                            });
                                        });
                                    </script>
                                </p>

                                <p class="imageuser">                          
                                    <img id="img_url" name="img_url" class="fas fa-user-circle" alt="your image" src="uploads/<c:out value="${user.getImage()}"/>" style="width: 100px; height: 100px; margin-left: 50px; margin-top: 20px;"><br>
                                    <input type="file" id="file" name ="file" accept="image/*" onload="img_pathUrlLoad(<c:out value="${user.getImage()}"/>);" onChange="img_pathUrl(this);">                                        
                                    <c:if test ="${not empty errorMessageUpdate}">
                                        <br>
                                        <label class="errorLabel"><c:out value = "${errorMessageUpdate}"/></label>
                                    </c:if>                                    
                                </p>
                                <p class="signup button"> 
                                    <input type="submit" value="Update"/> 
                                </p>
                            </div>
                                    
                        </form>
                        <script>
                            var loadFile = function (order) {
                                var image = document.getElementById("img_url");
                                image.src = URL.createObjectURL(event.target.files[0]);
                            };
                            function img_pathUrl(input){
                                $('#img_url')[0].src = (window.URL ? URL : webkitURL).createObjectURL(input.files[0]);
                            }
                            function img_pathUrlLoad(input){
                                $('#file')[0].value = (window.URL ? URL : webkitURL).createObjectURL(input.files[0]);
                            }
                        </script>
                    </div>
                </div>
            </div>  
        </div>
    </body>
</html>
