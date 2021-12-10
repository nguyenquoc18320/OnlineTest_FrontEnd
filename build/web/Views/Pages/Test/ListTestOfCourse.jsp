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
    <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
    <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/test.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/common.css" rel="stylesheet" type="text/css"/>
    <script src="Views/JS/user.js"></script>
    <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

    <title>Course Test</title>
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
                        <a href="detail-course?courseid=${Course.getId()}">Detail></a>
                        <a href="list-test?courseid=${Course.getId()}">List Tests</a>
                    </div>
                <div class="introduce-listtest">
                    <div >
                        <script>
                            setInterval(function () {
                                var colors = ['#004DE6', '#99001A', '#662200', '#660000', '#0F2107', '#070421', '#114506'];
                                var random_color = colors[Math.floor(Math.random() * colors.length)];
                                document.getElementById('fEtestlist').style.background = random_color;
                            }, 1000)
                        </script>
                        <div class="buttton-new-test">
                            <a href="create-test?courseid=<c:out value="${Course.getId()}"/>&start=1" ><input type="button" id="addquestion" class="newquestion" value="New Test"></a>                        
                        </div>
                        <c:forEach var = 'item' items='${testList}'>
                            <div class="borderlist" name="fEtestlist">
                                 <a href="show-result-author-test?testid=${item.getId()}"><p id="label_listtest"><c:out value="${item.getName()}"/></p></a> 
                                <!--<a id="label_listtest" href="test-result?courseid=<c:out value="${Course.getId()}"/>&testid=<c:out value="${item.getId()}&start=1"/>"><c:out value="${item.getName()}"/></a>-->
                                <c:choose>
                                    <c:when test="${item.isStatus()}">
                                        <i id="iconblock" style="position: absolute; left: 80%;font-size: 30px;cursor: pointer;color:#1FD818;" class="fa fa-unlock-alt" onclick="blockTest('${Course.getId()}','${item.getId()}')"></i>                                      
                                    </c:when>
                                    <c:otherwise >
                                        <i style="position: absolute;left: 80%;font-size: 30px;cursor: pointer;color:#000;" class="fa fa-lock" onclick="blockTest('${Course.getId()}','${item.getId()}')"></i>                                        
                                    </c:otherwise>
                                 </c:choose>
                                        <div style="display: inline;">
                                    <p id="list-descrip" >Duration: <c:out value="${item.getDuration()}"/> (minutes)</p>
                                    <p id="list-descrip"> Attempt number: <c:out value="${item.getAttemptnumber()}"/> </p> 
                                </div>        

                                <p style="display: inline;">
                                    <a id="questiontest" name="questiontest" href="add-question?courseid=<c:out value="${Course.getId()}"/>&testid=<c:out value="${item.getId()}&start=1"/>" >Question</a>
                                    <a id="updatetest" name="updatetest" href="update-test?courseid=<c:out value="${Course.getId()}"/>&testid=<c:out value="${item.getId()}"/>&start=1" >Update</a>
                                    <a id="deletetest" name="deletetest" onclick="deleteTest('${Course.getId()}', '${item.getId()}')">Delete</a>  
                                </p>
                            </div>
                        </c:forEach>                        
                    </div>
                    
                    <script>
                        function deleteTest(courseid, testid) {
                            if (confirm("Are you sure you want to delete the Test ?")) {
                                document.location.href = "delete-test?courseid=" + courseid + "&testid=" + testid;
                            } 
                        }
                        function blockTest(courseid, testid) {
                            if (confirm("Are you sure you want to change the test status?")) {
                                document.location.href = "block-unblock-test?courseid="+courseid+"&testid=" + testid;
                            }
                        }
                    </script>
                    <script>
                        // message
                        var message = "${alertMessage}";
                        if (message) {
                            alert(message);
                        }
                    </script>
                </div>                  
            </div>
        </div>
    </div>
</body>
</html>
