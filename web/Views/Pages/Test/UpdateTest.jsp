<%-- 
    Document   : UpdateTest
    Created on : Nov 8, 2021, 1:44:26 AM
    Author     : PhanSu
--%>


<%@page import="Object.Test"%>
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
    <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/test.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/common.css" rel="stylesheet" type="text/css"/>
    <script src="Views/JS/user.js"></script>
    <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

    <title>Update Test</title>
</head>
<body>
    <div class="container-full">
        <div class="side-bar">
            <div class="logo">
                <img src="Views/CSS/images/logo1.png">
            </div>
            <div class="profile">
                <img alt="No Image" src="uploads/<c:out value="${User.getImage()}"/>">
                <p><c:out value=""/>${User.getName()}</p>
                <p><c:out value=""/>${User.getEmail()}</p>

            </div>
            <div class="menu">
                <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                <button><a href=""><i class="fas fa-users"></i> Test Courses</a></button>
                <button><a href=""><i class="fas fa-book-open"></i> My Test Courses </a></button>
                <button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>
                <button><a href=""><i class="fas fa-user"></i> LogOut</a></button>
            </div>
        </div>
        <div class="wrapped">
            <div class="nav-bar">
                <h1>Create Test</h1>
                <div class="drop-down" id="drop-down-user">
                    <a href="log-in"><button>Log Out</button></a>
                </div>
                <i class="fas fa-user-circle" onclick="ToggleDropDown('drop-down-user')"></i>
            </div>
            <div class="content">
                <div class="introduce-test">
                    <form action="update-test?testid=${Test.getId()}" method="post" autocomplete="on">
                        <div class="introduce-profiletest">
                            <label for="listourse" class="label_test" data-icon="u" >Course: </label>                           
                            <select name="listourse" class="cbb_listcourse">                               
                                <c:forEach items="${courseList}" var="Course">
                                    <option value="${Course.id}" 
                                            <c:set var="courseid" value="${Course.id}"/>
                                            <c:set var="courseupdate" value="${CourseUpdate.id}"/>
                                            <c:if test="${courseid eq courseupdate}">selected="selected"</c:if>
                                                >
                                            ${Course.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div> 
                        <% Test testnow = (Test) request.getAttribute("Test");
                            request.setAttribute("testupdate", testnow);
                        %>
                        <div class="introduce-profiletest">
                            <label class="label_test" data-icon="u" >Test Name: </label>
                            <input id="testname" class="intput-test" name="testname" required="required" type="text" value="${Test.getName()}"/>
                        </div>
                        <div class="introduce-profiletest">
                            <label class="label_test" data-icon="u" >Description: </label>
                            <input id="description" class="intput-test" name="description" required="required" type="text" value="${Test.getDescription()}"/>
                        </div>
                        <div class="introduce-profiletest">
                            <label class="label_test" data-icon="u">Test Duration (Minutes): </label>
                            <input id="duration" name="duration" required="required" type="text" value="${Test.getDuration()}"/>
                        </div>
                        <div class="introduce-profiletest">
                            <label  class="label_test" data-icon="u">Attempt Number: </label>
                            <input id="attempt" name="attempt" required="required" type="text" value="${Test.getAttemptnumber()}"/>
                        </div>
                        <c:if test="${not empty errorMessage}">
                            <p id='errorMessage'><c:out value="${errorMessage}"/></p>
                        </c:if>
                            <div class="sm-profiletest" style="display: inline;">
                            <a id="updatetest" class="qs-profiletest" href="add-question?testid=<c:out value="${Test.getId()}&start=1"/>" value="Add Question" /> Question</a>
                            <input type="submit" value="Update" />
                            
                        </div>
                            
                    </form>
                </div>

            </div>
        </div>
</body>
</html>