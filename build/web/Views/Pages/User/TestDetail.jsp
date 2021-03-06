<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/User/TestDetail.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>Test Detail</title>
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
                        <a href="attended-course">Attended Courses></a>
                        <a href="not-done-tests-attended-course?courseid=${test.getCourse().getId()}"><c:out value="${test.getCourse().getName()}"/>></a>
                        <c:choose>
                            <c:when test="${not empty result.get('score')}">
                                <a href="done-tests?courseid=${test.getCourse().getId()}">Done></a>
                            </c:when>
                            <c:otherwise>
                                <a href="not-done-tests-attended-course?courseid=${test.getCourse().getId()}">Not Done></a>
                            </c:otherwise>
                        </c:choose>
                        <a href="test-detail?testid=${test.getId()}"><c:out value="${test.getName()}"/>></a>
                    </div>

                    <div class='content_wrap'>                     
                        <form id='formSubmit'action="start-test" method="POST">
                            <input hidden="" name="testid" value="<c:out value='${test.getId()}'/>">
                            <h3 id='testName'><c:out value="${test.getName()}"/></h3>
                            <h4 id='description'><c:out value='${test.getDescription()}'/></h4><br>
                            <div id="div_info">
                                Open: <label class='info'> <fmt:formatDate pattern = "HH:mm dd-MM-yyyy" value = "${test.getStart()}" /></label><br>
                                Close: <label id='info'> <fmt:formatDate pattern = "HH:mm dd-MM-yyyy" value = "${test.getEnd()}" /></label><br>
                                Duration for test: <label id='info'> <c:out value='${test.getDuration()}'/> minutes</label><br>
                                Attempt times: <label id='info'> <c:if test="${test.getAttemptnumber() gt 0}"><c:out value='${test.getAttemptnumber()}'/></c:if></label><br>
                                Result: <label id='info'><c:out value='${result.get("score")}'/> (<c:out value="${result.get('attempt')}"/> attempts)</label>
                                <a href='my-test-results?testid=${test.getId()}'><input id='btn_result' type='button' value="Results"></a><br>
                            </div>

                            <c:choose>
                                <c:when test="${continueStatus eq true}">
                                    <a href ="continue-test?testid=${test.getId()}"><input type="button" id='label_continue' value="CONTINUE"></a>
                                    </c:when>
                                    <c:when test="${(test.getStart() gt now) or (test.getEnd() lt now)}">

                                </c:when>
                                <c:otherwise>
                                    <c:if test="${(result.get('attempt') lt test.getAttemptnumber() ) or (empty result) or(test.getAttemptnumber() lt 1)}">
                                        <input id='submit' type='submit' value="START">
                                    </c:if>
                                </c:otherwise>
                            </c:choose>

                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="Views/JS/base.js"></script>
    </body>
</html>
