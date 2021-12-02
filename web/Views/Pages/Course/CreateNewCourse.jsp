<%-- 
    Document   : CreateNewCourse
    Created on : Oct 15, 2021, 10:59:40 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />
        <title>Create new course</title>
    </head>
    <body>
        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div id='div_functionName'>
                    <label id='functionName'>Create Course</label>
                </div>
            </div>

            <div class ='main'>
                <div class ='nav'><!--navigation buttons-->
                    <div class ='user_info'>

                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-user?page=1&maxPageItems=5">My Course></a>
                        <a href="create-course?start=1">Create Course></a>
                    </div>
                    

                    <div class='content_wrap'>
                        <form action="create-course" method="POST">
                            <label class='label_title'>Course name:</label>
                            <input type="text" class="text_input" name="courseName" required><br>

                            <label class='label_title'>Description:</label>
                            <textarea class="text_input" name = 'description' required></textarea><br>


                            <label class='label_title'>Course for: </label>
                            <input type="radio"  name="status" value="private" checked>
                            <label>Private</label>
                            <input type="radio"  name="status" value="public">
                            <label >Public</label><br>

                            <c:if test="${not empty errorMessage}">
                                <p id='errorMessage'><c:out value="${errorMessage}"/></p>
                            </c:if>


                            <input id="create_button" type='submit' value="CREATE">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
