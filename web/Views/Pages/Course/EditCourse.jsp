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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/EditCourse.css" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <title>Create new course</title>
    </head>
    <body>
        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div id='div_functionName'>
                    <label id='functionName'>Update Course</label>
                </div>
            </div>

            <div class ='main'>
                <div class ='navi'><!--navigation buttons-->
                    <div class ='profile'>
                        <img alt="No Image" src="uploads/<c:out value="${User.getImage()}"/>">
                        <p><c:out value=""/>${user.getName()}</p>
                        <p><c:out value=""/>${user.getEmail()}</p>
                    </div>
                    <div class="menu">
                        <button><a href="Home"><i class="fa fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fa fa-address-book"></i> My Information</a></button>
                        <button><a href="attended-course"><i class="fa fa-users"></i>Attended Courses</a></button>
                        <button><a href="manage-course-user"><i class="fa fa-book-open"></i> My Test Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fa fa-user"></i> LogOut</a></button>
                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-user">My Course></a>
                        <a href="edit-course?start=1&courseid=<c:out value='${course.getId()}'/>">Edit Course></a>
                        <lable ><c:out value ="${course.getName()}"/></lable>
                    </div>

                    <div class='content_wrap'>
                        <form action="edit-course" method="POST">
                            <input type="hidden" name="courseid" value ="<c:out value='${course.getId()}'/>">
                            <label class='label_title'>Course name:</label>
                            <input type="text" class="text_input" name="courseName" required value="<c:out value='${course.getName()}'/>"><br>

                            <label class='label_title'>Description:</label>
                            <textarea class="text_input" name = 'description' required><c:out value='${course.getDescription()}'/></textarea><br>


                            <label class='label_title'>Course for: </label>
                            <input type="radio"  name="status" value="private" checked>
                            <label>Private</label>

                            <c:choose>
                                <c:when test="${course.getStatus()}">
                                    <input type="radio"  name="status" value="public" checked>
                                    <label >Public</label><br>
                                </c:when>
                                <c:otherwise >
                                    <input type="radio"  name="status" value="public">
                                    <label >Public</label><br>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${not empty errorMessage}">
                                <p style="color:#FF0000;" id='errorMessage'><c:out value="${errorMessage}"/></p>
                            </c:if>
                            <c:if test="${not empty infoMessage}">
                                <p style="color:#0040FF" id='infoMessage'><c:out value="${infoMessage}"/></p>
                            </c:if>

                            <div class="div_btn">
                                <input  id="btn_delete" type="button" value='Delete' onclick="deleteCourse('${course.getId()}')">
                                <input id="create_button" type='submit' value="Update">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function deleteCourse(courseid) {
                if (confirm("Are you sure you want to delete the course ?")) {
                    document.location.href = "delete-course?courseid=" + courseid;
                } else {
                    //                    console.info("Cancel");
                }
            }
        </script>
    </body>
</html>
