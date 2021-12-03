<%-- 
    Document   : SignUp
    Created on : Oct 4, 2021, 4:13:52 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/signup.css" />
        <title>Sign Up</title>
    </head>
    <body>
        <div class="container">         			
            <div id="container_demo" >
            <div id = "header">
                <img id = "logo" src="Views/CSS/images/logo1.png" alt="Logo">
            </div>
                <div id="wrapper">
                    <div id="register" class="animate form">
                        <form  action="sign-up" autocomplete="on" method = "POST"> 
                            <h1> Sign up </h1> 
                            <p> 
                                <label for="usernamesignup" class="uname" data-icon="u">Your name</label>
                                <input id="usernamesignup" name="name" required="required" type="text" value ="<c:out value="${name}"/>" />
                            </p>
                            <p> 
                                <label for="emailsignup" class="youmail" data-icon="e" > Your email</label>
                                <c:if test ="${not empty emailError}">
                                    <br>
                                    <label class="errorLabel"><c:out value = "${emailError}"/></label>
                                </c:if>
                                <input id="emailsignup" name="email" required="required" type="email" value ="<c:out value="${email}"/>"/> 
                            </p>
                            <p> 
                                <label for="passwordsignup" class="youpasswd" data-icon="p">Your password </label>
                                <c:if test ="${not empty passwordError}">
                                    <br>
                                    <label class="errorLabel"><c:out value = "${confirmPasswordError}"/></label>
                                </c:if>
                                <input id="passwordsignup" name="password" required="required" type="password" minlength="8" />
                            </p>
                            <p> 
                                <label for="passwordsignup_confirm" class="youpasswd" data-icon="p">Please confirm your password </label>
                                <c:if test ="${not empty confirmPasswordError}">
                                    <br>
                                    <label class="errorLabel"><c:out value = "${confirmPasswordError}"/></label>
                                </c:if>
                                <input id="passwordsignup_confirm" name="confirmPassword" required="required" type="password" minlength="8"/>
                                <c:if test ="${not empty errorMessage}">
                                    <br>
                                    <label class="errorLabel"><c:out value = "${errorMessage}"/></label>
                                </c:if>
                            </p>
                            <p class="signup button"> 
                                <input type="submit" value="Sign up"/> 
                            </p>
                            <p class="change_link">  
                                Already a member ?
                                <a href="log-in?start=1" class="to_register"> Go and log in </a>
                            </p>
                        </form>
                    </div>
                </div>
            </div>  
        </div>
    </body>
</html>
