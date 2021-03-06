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
        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <title>Create new course</title>
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
                        <button><a href="attended-course"><i class="fas fa-users"></i>Attended Courses</a></button>
                        <button><a href="manage-course-user" ><i class="fas fa-book-open" style='background-color: #5531FB; color:white'></i> My Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-sign-out-alt"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-user">My Course></a>
                        <a href="edit-course?start=1&courseid=<c:out value='${course.getId()}'/>">Edit Course></a>
                        <lable ><c:out value ="${course.getName()}"/></lable>
                    </div>

                    <div class='content_wrap'>
                        <form id='formSubmit' action="edit-course" method="POST">
                            <h1>Update Course</h1>
                            <input type="hidden" name="courseid" value ="<c:out value='${course.getId()}'/>">
                            <label class='label_title'>Course name:</label><br>
                            <input type="text" class="text_input" name="courseName" required value="<c:out value='${course.getName()}'/>"><br>

                            <label class='label_title'>Description:</label><br>
                            <textarea class="text_input" name = 'description' required><c:out value='${course.getDescription()}'/></textarea><br>


                            <label class='label_title'>Course for: </label><br>
                            <input type="radio"  name="status" value="private" checked>
                            <label class='label_for_status'>Private</label>

                            <c:choose>
                                <c:when test="${course.getStatus()}">
                                    <input type="radio"  name="status" value="public" checked>
                                    <label class='label_for_status' >Public</label><br>
                                </c:when>
                                <c:otherwise >
                                    <input type="radio"  name="status" value="public">
                                    <label class='label_for_status'>Public</label><br>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${not empty errorMessage}">
                                <p style="color:#FF0000;" id='errorMessage'><c:out value="${errorMessage}"/></p>
                            </c:if>
                            <c:if test="${not empty infoMessage}">
                                <p style="color:#0040FF" id='infoMessage'><c:out value="${infoMessage}"/></p>
                            </c:if>

                            <div class="div_btn">
                                <input id="create_button" type='submit' value="Update">
                                <input  id="btn_delete" type="button" value='Delete' onclick="deleteCourse('${course.getId()}')">

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
