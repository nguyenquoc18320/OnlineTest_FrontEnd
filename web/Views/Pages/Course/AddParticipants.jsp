
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/AddParticipants.css" />
        <title>Add Participants</title>
    </head>
    <body>
        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div id='div_functionName'>
                    <label id='functionName'><c:out value="${course.getName()}"/></label>
                </div>
            </div>

            <div class ='main'>
                <div class ='nav'><!--navigation buttons-->
                    <div class ='user_info'>

                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                         <a href="manage-course-user">My Course></a>
                        <a href="detail-course?courseid=${course.getId()}"><c:out value="${course.getName()}"/>></a>
                        <a href="manage-participants?courseid=${course.getId()}">Participants></a>   
                        <a href="add-participants?courseid=${course.getId()}">Add Participants></a>
                    </div>
                    
                    <div class='content_wrap'>
                        <form action="add-participants" method="POST">
                            <p >
                                You can add many participants concurrently.Each email should be on a line.
                            </p>
                            <input type='hidden' name='courseid' value="<c:out value='${course.getId()}'/>">
                            <label class='label_title'>Participants' email:</label>
                            <textarea class="text_input" name = 'email'><c:if test="${not empty email}"><c:out value="${email}"/></c:if></textarea><br>

                            <label class='label_title'>Result: </label>
                            <textarea readonly class="text_input" name = 'result'><c:if test="${not empty email}"><c:out value="${result}"/></c:if></textarea><br>

                            <input id="add_button" type='submit' value="ADD">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
