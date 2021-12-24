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
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/DetailCourse.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
        <link href="Views/CSS/su/common.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title><c:out value="${course.getName()}"/></title>

    </head>
    <body>

        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
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
                        <button><a href="attended-course"><i class="fas fa-users" ></i>Attended Courses</a></button>
                        <button><a href="manage-course-user" ><i class="fas fa-book-open" style='background-color: #5531FB; color:white'></i> My Courses </a></button>
                        <button><a href="log-out"><i class="fas fa-sign-out-alt"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-user">My Course></a>
                        <a href="detail-course?courseid=${course.getId()}"><c:out value="${course.getName()}"/>></a>
                    </div>

                    <div class='content_wrap'>
                        <div class ="div_participants">
                            <button id="btn_participants"><a href = "manage-participants?courseid=${course.getId()}" id="link_show_participants"><i class="fa fa-users">Participants:  <c:out value="${numberParticipants}"/></i></a></button>
                            <!--<label id="num_participants">Number of registers: </label>-->
                        </div>
                        <div class="div_tests">
                            <button id='btn_tests'> <a href="list-test?courseid=${course.getId()}" id="link_show_tests"><i class="fa fa-tasks">Test</i></a></button>
                            <label class="num_tests">Total Tests: <c:out value="${numberTests}"/></label>
                        </div>
                        <c:if test="${not empty errorMessage}">
                            <br><label id="errorMessage"><c:out value="${errorMessage}"/></label> 

                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
