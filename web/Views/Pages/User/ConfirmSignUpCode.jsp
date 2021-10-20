<%-- 
    Document   : ConfirmSignUpCode
    Created on : Oct 11, 2021, 3:58:25 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/confirmSignUpCode.css" />
        <title>Confirm code</title>
    </head>
    <body>
        <div class="wrapper">
            <div class="dialog">
                <!--                <button class="close">×</button>-->
                <img id="logo" src="Views/CSS/images/logo1.png" alt="logo">
                <h3>Please enter the 4-digit verification code we sent to email <c:out value="${email}"/></h3>
                <!--<span>(we want to make sure it's you before we contact our movers)</span>-->
                <form action = "confirm-signup-code" method="POST">
                    <div id="form">
                        <label id='errorMessage'> <c:out value="${errorMessage}"/></label> <br>
                        <input type="hidden" name="name" value="<c:out value='${name}'/>">
                        <input type="hidden" name="email" value="<c:out value='${email}'/>">
                        <input type="hidden" name="password" value="<c:out value='${password}'/>">
                        <input class="digit" type="text" maxLength="1" size="1" min="0" max="9" pattern="[0-9]{1}" required="required" name="number1"/>
                        <input class="digit" type="text" maxLength="1" size="1" min="0" max="9" pattern="[0-9]{1}" required="required" name='number2'/>
                        <input class="digit" type="text" maxLength="1" size="1" min="0" max="9" pattern="[0-9]{1}" required="required" name='number3'/>
                        <input class="digit" type="text" maxLength="1" size="1" min="0" max="9" pattern="[0-9]{1}" required="required" name='number4'/>
                        <input class="digit" type="text" maxLength="1" size="1" min="0" max="9" pattern="[0-9]{1}" required="required" name='number5'/>
                        <input class="digit" type="text" maxLength="1" size="1" min="0" max="9" pattern="[0-9]{1}" required="required" name='number6'/>
                        <input type ='submit' id="btnSubmit" class="btn btn-primary btn-embossed" value ="Verify">
                    </div>
                </form>
                <div>
                    Didn't receive the code? 
                    <a href="#">Send code again</a><br />
                    <a href="sign-up?start=1">To Sign Up</a>
                </div>
            </div>
        </div>
    </body>
</html>
