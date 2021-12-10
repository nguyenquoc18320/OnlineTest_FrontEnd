<%-- 
    Document   : TestResult
    Created on : Dec 4, 2021, 1:33:14 AM
    Author     : PhanSu
--%>

<%@page import="java.util.Date"%>
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
    <link rel="stylesheet" type="text/css" href="Views/CSS/CourseManager_user.css" />
    <script src="Views/JS/user.js"></script>
    <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

    <title>Results</title>
</head>
<body>
    <div class="container-full">
        <div class="side-bar">
            <div class="logo">
                <img src="Views/CSS/images/logo1.png">
            </div>
            <div class="profile">
                <c:if test ="${not empty user.getImage()}">
                    <img  class="imageuserinfor" alt="No Image" src="uploads/<c:out value="${user.getImage()}"/>">
                </c:if>
                <c:if test ="${empty user.getImage()}">
                    <img src="Views/CSS/images/userinfor.png">
                </c:if>
                <p><c:out value=""/>${user.getName()}</p>
                <p><c:out value=""/>${user.getEmail()}</p>

            </div>
            <div class="menu">
                <button><a href="#"><i class="fas fa-home"></i>Home</a></button>
                <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                <button><a href="attended-course"><i class="fas fa-users"></i>Attended Courses</a></button>
                <button><a href="manage-course-user"><i class="fas fa-book-open"></i> My Test Courses </a></button>
                <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
            </div>
        </div>
        <div class="wrapped">
            <div class="nav-bar">
                <h1>Test Results</h1>
                <div class="drop-down" id="drop-down-user">
                    <a href="log-in"><button>Log Out</button></a>
                </div>
                <i class="fas fa-user-circle" onclick="ToggleDropDown('drop-down-user')"></i>
            </div>
            <div class="content">
                <div class="introduce-test">
                    <div class="introduce-profiletest">                        
                        <select id="listcourse" class="cbb_listcourseresult" onchange="ChangeList()">                               
                            <c:forEach items="${courseList}" var="Course">
                                <option value="${Course.id}" 
                                        <c:set var="courseid" value="${Course.id}"/>
                                        <c:set var="courseCurrent" value="${CourseCurrent.getId()}"/>
                                        <c:if test="${courseid eq courseCurrent}">selected="selected"</c:if>
                                            >
                                        ${Course.name}
                                </option>
                            </c:forEach>
                        </select>
                        <a id="tempt"></a>
                        <select id="listtest" class="cbb_listcourseresult" onchange="ChangeTest()">                               
                            <c:forEach items="${testList}" var="Test">
                                <option value="${Test.id}" 
                                        <c:set var="testid" value="${Test.id}"/>
                                        <c:set var="testCurrent" value="${TestCurrent.getId()}"/>
                                        <c:if test="${testid eq testCurrent}">selected="selected"</c:if>
                                            >
                                        ${Test.name}
                                </option>
                            </c:forEach>
                        </select>   
                     
                        <!--<a id="searchresult" class="search_result" href="" value="" /> Search</a>-->
                    </div>
                    <div class="introduce-profiletest">
                        <table id="course" class="table table-bordered table table-hover" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th class ='table_name_header'>Name</th>
                                            <th class ='table_public_header'>Attempt</th>
                                            <th class ='table_edit_header'>Score</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty testResultList}">
                                        <c:forEach var='item2' items='${testResultList}'>
                                            <tr>
                                                <td class="table_name">
                                                    <c:out value="${item2.getUser().getName()}"/>
                                                </td>
                                                <td class="table_check_icon">                                                   
<!--                                                    <i id="icon_check" class="fa fa-check-circle"></i>                                                   -->
                                                        <c:out value="${item2.getAttempt()}"/>
                                                </td>

                                                <td class = "table_edit">
                                                   <c:out value="${item2.getScore()}"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    </tbody>
                            </table>
                    </div>
                    <script>
                        function ChangeList(){
                            var select = document.getElementById('listcourse');
                            var value = select.options[select.selectedIndex].value;
                            document.getElementById("tempt").href = 'test-result?courseid='+value+'&start=-1';
                            document.getElementById("tempt").click();
                        }
                    </script>
                    <script>
                        function ChangeTest(){
                            var selectCourse = document.getElementById('listcourse');
                            var valuecourse = selectCourse.options[selectCourse.selectedIndex].value;
                            var select2 = document.getElementById('listtest');
                            var value2 = select2.options[select2.selectedIndex].value;
                            document.getElementById("tempt").href = 'test-result?courseid='+valuecourse+'&testid='+value2+'&start=1';
                            document.getElementById("tempt").click();
                        }
                    </script>
                </div>

            </div>
        </div>
</body>
</html>