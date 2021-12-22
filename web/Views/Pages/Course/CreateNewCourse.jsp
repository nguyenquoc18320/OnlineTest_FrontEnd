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
        <meta name="viewport" content="width=device-width, initial-scale=1">     
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">

        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <title>Create new course</title>
    </head>
    <body>
        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                    <label id="label_close_menu" onclick="closeMenu()">X</label>
                </div>
                <div class ='navi'><!--navigation buttons-->
                    <div class ='profile'>
                        <img alt="No Image" src="uploads/<c:out value="${user.getImage()}"/>">
                        <div class='info'>
                            <p id='info_name'><c:out value=""/>${user.getName()}</p>
                            <p id='info_email'><c:out value=""/>${user.getEmail()}</p>
                        </div>
                    </div>
                    <div class="menu">
                        <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Profile</a></button>
                        <button><a href="attended-course"><i class="fas fa-users" style='background-color: #5531FB; color:white'></i>Attended Courses</a></button>
                        <button><a href="manage-course-user" ><i class="fas fa-book-open"></i> My Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-sign-out-alt"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <i class="fa fa-bars" onclick="changeMenuDisplay()"></i>
                        <a href="manage-course-user?page=1&maxPageItems=5">My Course></a>
                        <a href="create-course?start=1">Create Course></a>
                    </div>
                    <div class='content_wrap'>
                        <form id='div_create_course' action="create-course" method="POST">
                            <h1 id='course_name'>Create Course</h1> 
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
        <script src="Views/JS/base.js"></script>
    </body>
</html>
