<%-- 
    Document   : Login
    Created on : Oct 9, 2021, 11:14:58 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/login.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/su/login.css" />
        <title>Login</title>
    </head>
    <body>		
        <div id="container_demo" > 
            <div id = "header">
                <img id = "logo" src="Views/CSS/images/logo1.png" alt="Logo">
            </div>
            <div id="wrapper">
                <div id="login" class="animate form">
                    <form  action="log-in" method="POST"> 
                        <h1>Log in</h1> 
                        <p> 
                            <label for="username" class="email" data-icon="u" > Your email </label>
                            <input id="username" name="email" required="required" type="email"  value = '<c:out value="${email}"/>' />
                        </p>
                        <p> 
                            <label for="password" class="password" data-icon="p"> Your password </label>
                            <input id="password" name="password" required="required" type="password"  value = '<c:out value="${password}"/>'/> 
                        </p>
                        <c:if test="${not empty errorMessage}">
                            <label class="error"> <c:out value="${errorMessage}"/> </label>
                        </c:if>
                        <p class="login button"> 
                            <input type="submit" value="Login" /> 
                        </p>
                        <p class="change_link">
                            Not a member yet ?
                            <a href="sign-up?start=1" class="to_register">Join us</a>
                        </p>                     
                    </form>                       
                    <button class="open-button" onclick="openForm()">Forget Password</button>
                    <div class="form-popup" id="myForm">
                      <form action="pass-login" class="form-container" method="POST">
                        <h2>Forget Password</h2>
                        <label for="email"><b>Your Email:</b></label>
                        <input type="text" placeholder="Enter Email" name="email-forget" required>
                        <c:if test ="${not empty EmailFogetError}">
                            <br>
                            <label class="errorLabel"><c:out value = "${EmailFogetError}"/></label>
                        </c:if>
<!--                        <label for="psw"><b>Confirm Code From Your Email:</b></label>
                        <input type="password" placeholder="Enter Password" name="psw" required>-->
                        <button type="submit" class="btn">Confirm Code </button>
                        <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
                      </form>
                    </div>
                    <script>
                        function openForm() {
                          document.getElementById("myForm").style.display = "block";
                        }
                        function closeForm() {
                          document.getElementById("myForm").style.display = "none";
                        }
                    </script>
                </div>			
            </div>                       
        </div>  
    </body>
</html>