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
                </div>			
            </div>
        </div>  
    </body>
</html>
