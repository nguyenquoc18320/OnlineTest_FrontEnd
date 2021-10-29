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
        <link rel="stylesheet" type="text/css" href="Views/CSS/EditCourse.css" />
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
                <div class ='nav'><!--navigation buttons-->
                    <div class ='user_info'>

                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course">My Course></a>
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
                                <p id='errorMessage'><c:out value="${errorMessage}"/></p>
                            </c:if>
                                <c:if test="${not empty infoMessage}">
                                <p id='infoMessage'><c:out value="${infoMessage}"/></p>
                            </c:if>

                            <input id="create_button" type='submit' value="UPDATE">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
