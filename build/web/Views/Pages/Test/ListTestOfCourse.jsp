<%-- 
    Document   : ListTest
    Created on : Nov 12, 2021, 1:29:12 AM
    Author     : PhanSu
--%>


<%@page import="Object.Test"%>
<%@page import="Object.Course"%>
<%@page import="java.util.List"%>
<%@page import="Object.Course"%>
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

    <title>Course Test</title>
</head>
<body>
           

                         
    <div class="container-full">
        <div class="side-bar">
            <div class="logo">
                <img src="Views/CSS/images/logo1.png">
            </div>
            <div class="profile">
                <img alt="No Image" src="uploads/<c:out value="${user.getImage()}"/>">
                <p><c:out value=""/>${user.getName()}</p>
                <p><c:out value=""/>${user.getEmail()}</p>

            </div>
            <div class="menu">
                <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                <button><a href="UserInformation"><i class="fas fa-address-book"></i> My Information</a></button>
                <button><a href="list-test?start=1"><i class="fas fa-users"></i> Test Courses</a></button>
                <button><a href="Views/Pages/Test/CreateTest.jsp"><i class="fas fa-book-open"></i> My Test Courses </a></button>
                <button><a href="add-question?start=1"><i class="fas fa-splotch"></i>Result </a></button>
                <button><a href=""><i class="fas fa-user"></i> LogOut</a></button>>
            </div>
        </div>
        <div class="wrapped">
            <div class="nav-bar">
                <h1>List of Tests of the Course</h1>
                <div class="drop-down" id="drop-down-user">
                    <a href="log-in"><button>Log Out</button></a>
                </div>
                <i class="fas fa-user-circle" onclick="ToggleDropDown('drop-down-user')"></i>
            </div>            
            <div class="content">
                <div class="introduce-listtest">
                    <div >
                        <script>
                            setInterval(function(){
                                var colors = ['#004DE6', '#99001A', '#662200', '#660000', '#0F2107', '#070421', '#114506'];
                                var random_color = colors[Math.floor(Math.random() * colors.length)];
                                document.getElementById('fEtestlist').style.background = random_color;
                            },1000)
                        </script>
                        <c:forEach var = 'item' items='${testList}'>
                            <div class="borderlist" name="fEtestlist">
                                <p id="label_listtest"><c:out value="${item.getName()}"/></p>
                                <p id="list-descrip" >Duration: <c:out value="${item.getDuration()}"/> (minutes)</p>
                                <p id="list-descrip"> Attempt number: <c:out value="${item.getAttemptnumber()}"/> </p>
                                <p style="display: inline;">
                                    <a id="questiontest" name="questiontest" href="add-question?courseid=<c:out value="${Course.getId()}"/>&testid=<c:out value="${item.getId()}&start=1"/>" >Question</a>
                                    <a id="updatetest" name="updatetest" href="update-test?courseid=<c:out value="${Course.getId()}"/>&testid=<c:out value="${item.getId()}"/>&start=1" >Update</a>
                                    <a id="deletetest" name="deletetest" href="delete-test?courseid=<c:out value="${Course.getId()}"/>&testid=<c:out value="${item.getId()}"/>" >Delete</a>  
                                </p>
                            </div>
                        </c:forEach>                        
                    </div>
                    <div class="buttton-new-test">
                        <a href="create-test?courseid=<c:out value="${Course.getId()}"/>&start=1" ><input type="button" id="addquestion" class="newquestion" value="New Test"></a>                        
                    </div>
                </div>
            </div>
        </div>
</body>
</html>
