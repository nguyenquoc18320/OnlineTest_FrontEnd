
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/AddParticipants.css" />
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
        <title>Add Participants</title>
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
                        <a href="manage-course-user">My Course></a>
                        <a href="detail-course?courseid=${course.getId()}"><c:out value="${course.getName()}"/>></a>
                        <a href="manage-participants?courseid=${course.getId()}">Participants></a>   
                        <a href="add-participants?courseid=${course.getId()}">Add Participants></a>
                    </div>

                    <div class='content_wrap'>
                        <form  id = 'formSubmit' action="add-participants" method="POST">
                            <h1 id='course_name'><c:out value="${course.getName()}"/></h1>
                            <p >
                                You can add many participants concurrently.Each email should be on a line.
                            </p>
                            <input type='hidden' name='courseid' value="<c:out value='${course.getId()}'/>">
                            <label class='label_title'>Participants' email:</label>
                            <textarea class="text_input" name = 'email'><c:if test="${not empty email}"><c:out value="${email}"/></c:if></textarea><br>

                                <label class='label_title'>Result: </label>
                                <textarea readonly class="text_input" name = 'result'><c:if test="${not empty email}"><c:out value="${result}"/></c:if></textarea><br>

                            <div id='div_btn_submit'><input id="add_button" type='submit' value="ADD"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
