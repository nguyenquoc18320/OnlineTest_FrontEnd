<%-- 
    Document   : ForgetPassword
    Created on : Nov 1, 2021, 5:49:06 PM
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
        <title>Forget Password</title>
    </head>
    <body>
        <div class="container">         			
            <div id="container_demo" >
            <div id = "header">
                <img id = "logo" src="Views/CSS/images/logo1.png" alt="Logo">
            </div>
                <div id="wrapper">
                    <div id="register" class="animate form">
                        <form  action="forgetpass" autocomplete="on" method = "POST" >
                            <h1>Forget Password </h1> 
                            
                            <div id="form-right">
                                <p> 
                                    <label for="emailchange" class="youmail" data-icon="e" > Your email</label>
                                    <input id="emailchange" name="emailchange" required="required" type="email" value ="<c:out value="${User.getEmail()}"/>" disabled/>
                                </p>
                                <p> 
                                    <label for="confirmcode" class="youcode" data-icon="p">Confirm Code From Your Email </label>
                                    <input id="confirmcode" name="confirmcode" required="required" type="text" />
                                    <c:if test ="${not empty confirmCodeError}">
                                        <br>
                                        <label class="errorLabel"><c:out value = "${confirmCodeError}"/></label>
                                    </c:if>
                                </p>
                                <p> 
                                    <label for="passwordchange" class="youpasswd" data-icon="p">New your password </label>
                                    <input id="passwordchange" name="passwordnew" required="required" type="password" />
                                    <c:if test ="${not empty passwordError}">
                                        <br>
                                        <label class="errorLabel"><c:out value = "${passwordError}"/></label>
                                    </c:if>
                                </p>
                                <p> 
                                    <label for="passwordchange_confirm" class="youpasswdold" data-icon="p">Please confirm your password </label>
                                    <c:if test ="${not empty confirmPasswordError}">
                                        <br>
                                        <label class="errorLabel"><c:out value = "${confirmPasswordError}"/></label>
                                    </c:if>
                                    <input id="passwordchange_confirm" name="confirmPassword" required="required" type="password" />
                                    <c:if test ="${not empty errorMessage}">
                                        <br>
                                        <label class="errorLabel"><c:out value = "${errorMessage}"/></label>
                                    </c:if>
                                </p>
                                <p class="signup button"> 
                                    <input type="submit" value="Update"/> 
                                </p>
                            </div>                                   
                        </form>
                    </div>
                </div>
            </div>  
        </div>
    </body>
</html>
