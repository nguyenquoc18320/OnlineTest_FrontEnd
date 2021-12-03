<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/User/CourseDetailForOther.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>Join Course</title>
    </head>
    <body>
        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div id='div_functionName'>
                    <label id='functionName' style="color: #4D4DFF"><c:out value="${course.getName()}"/></label>
                </div>
            </div>

            <div class ='main'>
                <div class ='navi'><!--navigation buttons-->
                    <div class ='profile'>
                        <img alt="No Image" src="uploads/<c:out value="${user.getImage()}"/>">
                        <p><c:out value=""/>${user.getName()}</p>
                        <p><c:out value=""/>${user.getEmail()}</p>
                    </div>
                    <div class="menu">
                        <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                        <button><a href="attended-course"><i class="fas fa-users"></i>Attended Courses</a></button>
                        <button><a href="manage-course-user"><i class="fas fa-book-open"></i> My Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="Home">Home></a>
                        <a href="course-detail-for-others?courseid=${course.getName()}"><c:out value="${course.getName()}"/>></a>
                    </div>

                    <div class='content_wrap'>                     
                        <form id='formSubmit'action="join-course" method="POST">
                            <input hidden="" name="courseid" value="<c:out value='${course.getId()}'/>">
                            <h3 id='testName'><c:out value="${test.getName()}"/></h3>
                            <h4 id='description'><c:out value='${test.getDescription()}'/></h4><br>
                            <div id="div_info">

                                <label id='label_description'>Description: <c:out value='${course.getDescription()}'/> </label><br>
                                <label id='label_author'>Author: <c:out value='${course.getUser().getName()}'/></label>
                                <label id='label_email'>(<c:out value='${course.getUser().getEmail()}'/>)</label><br>
                                <c:choose>
                                    <c:when test='${(not empty joinCourse) and joinCourse eq true}'>
                                        <a href="not-done-tests-attended-course?courseid=${course.getId()}"><input type='button' class ="btn_submit" value="Go to Course"></a>
                                        </c:when>
                                        <c:otherwise>
                                        <input class="btn_submit" type='submit' value="Register">
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var message = "${errorMessage}";
            if (message) {
                alert(message);
            }
        </script>
    </body>
</html>
