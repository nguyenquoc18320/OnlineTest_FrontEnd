<%-- 
    Document   : CreateTest
    Created on : Nov 10, 2021, 10:22:25 PM
    Author     : PhanSu
--%>

<%@page import="Object.Course"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" integrity="sha512-d9xgZrVZpmmQlfonhQUvTR7lMPtO7NkZMkA0ABN3PHCbKA5nqylQ/yWlFAyY6hYgdF1Qh6nYiuADWwKB4C2WSw==" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
    <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/test.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/common.css" rel="stylesheet" type="text/css"/>
    <script src="Views/JS/user.js"></script>
    <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

    <title>Create Test</title>
</head>
<body>
    <div class='wrap'>

            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div class ='navi'><!--navigation buttons-->
                    <div class ='profile'>
                        <c:if test ="${not empty user.getImage()}">
                            <img class="imageuserinfor" alt="No Image" src="uploads/<c:out value="${user.getImage()}"/>">
                        </c:if>
                        <c:if test ="${empty user.getImage()}">
                            <img src="Views/CSS/images/userinfor.png">
                        </c:if>
                        <div class='info'>
                            <p id='info_name'><c:out value=""/>${user.getName()}</p>
                            <p id='info_email'><c:out value=""/>${user.getEmail()}</p>
                        </div>
                    </div>
                    <div class="menu">
                        <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book" ></i> My Profile</a></button>
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
                        <a href="manage-course-user">My Courses></a>
                        <a href="detail-course?courseid=${CourseCurrent.getId()}">Detail></a>
                        <a href="list-test?courseid=${CourseCurrent.getId()}">List Tests</a>
                        <a>Create Test></a>
                    </div>
                <div class="introduce-test">
                    <form action="create-test?courseid=${CourseCurrent.getId()}" method="post" autocomplete="on">
                        <div class="introduce-profiletest">
                            <label id ='label_function_name'>New Test</label>
                            <label for="listourse" class="label_test" data-icon="u" >Course: </label>                           
                            <select name="listourse" class="cbb_listcourse">                               
                                <c:forEach items="${courseList}" var="Course">
                                    <option value="${Course.id}" 
                                            <c:set var="courseid" value="${Course.id}"/>
                                            <c:set var="coursecurrent" value="${CourseCurrent.id}"/>
                                            <c:if test="${courseid eq coursecurrent}">selected="selected"</c:if>
                                                >
                                            ${Course.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="introduce-profiletest">
                            <label class="label_test" data-icon="u" >Test Name: </label>
                            <input id="testname" class="intput-test" name="testname" required="required" type="text" value=""/>
                        </div>
                        <div class="introduce-profiletest">
                            <label class="label_test" data-icon="u" >Description: </label>
                            <input id="description" class="intput-test" name="description" required="required" type="text" value=""/>
                        </div>                                            
                        <div class="introduce-profiletest">
                            <label class="label_test" data-icon="u">Test Duration (Minutes): </label>
                            <input id="duration" name="duration" required="required" type="text" value=""/>
                        </div>
                        <div class="introduce-profiletest">
                            <label  class="label_test" data-icon="u">Attempt Number: </label>
                            <input id="attempt" name="attempt" required="required" type="text" value=""/>
                        </div>
                        <div class="datetest">
                            <div class="introducedatetest">
                                <label class="label_test" data-icon="u">Start Test: </label>
                                <input id="starttest" name="starttest" required="required" type="datetime-local" value=""/>
                            </div>
                            <div class="introducedatetest2">
                                <label class="label_test" data-icon="u">End Test: </label>
                                <input id="endtest" name="endtest" required="required" type="datetime-local" value=""/>
                            </div> 
                        </div>
                        <c:if test="${not empty errorMessage}">
                            <p id='errorMessage'><c:out value="${errorMessage}"/></p>
                        </c:if>
                        <div class="sm-profiletest">
                            <input type="submit" value="Create" />
                        </div>
                        <script>                            
                            var now = new Date();
                            now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
                            document.getElementById('starttest').value = now.toISOString().slice(0,16);
                            document.getElementById('endtest').value = now.toISOString().slice(0,16);
                        </script>
                    </form>
                </div>

            </div>
        </div>
    </div>
</body>
</html>

