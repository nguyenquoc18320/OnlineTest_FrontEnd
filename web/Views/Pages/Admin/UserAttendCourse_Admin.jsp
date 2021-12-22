<%-- 
    Document   : UserAtemptCouser_Admin
    Created on : Dec 11, 2021, 12:52:11 AM
    Author     : PhanSu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/AttendedCourses.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
        <link href="Views/CSS/su/test.css" rel="stylesheet" type="text/css"/>
        <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
        <link href="Views/CSS/su/common.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>Attended Course</title>
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
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                        <button><a href="manage-user"><i class="fas fa-users"></i>Manage users</a></button>
                        <button><a href="manage-course-admin"><i class="fas fa-book-open"></i>Manage Courses </a></button>
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-user">Manage users> </a>
                        <a>Attended Courses></a>                     
                    </div>

                    <div class='content_wrap'>
                        <label id ='label_function_name'>User Courses</label>
                        <div>
                            <select id="listuser" name="listuser" class="cbb_listuser_attend" onchange="ChangeList()">                               
                                <c:forEach items="${userList}" var="userlist">
                                    <option value="${userlist.id}" 
                                            <c:set var="userlistid" value="${userlist.id}"/>
                                            <c:set var="usernow" value="${usersearch}"/>
                                            <c:if test="${userlistid eq usernow}">selected="selected"</c:if>
                                                >
                                            ${userlist.name} (${userlist.email})
                                    </option>
                                </c:forEach>
                            </select>
                            <a id="tempt"></a>
                        </div>
                        <form id='formSubmit'action="" method="POST">
                            <c:forEach var="course" items="${coursePagination.getEntityList()}">
                                <div class='div_course'>
                                   
                                    <c:choose>
                                        <c:when test="${course.getBlocked()}">
                                            <label class='courseName'><c:out value="${course.getName()}"/></label><br>
                                        </c:when>
                                        <c:otherwise>
                                            <label class='courseName'><a class="courseName" href="#"><c:out value="${course.getName()}"/></a></label><br>
                                            </c:otherwise>
                                        </c:choose>
                                    <!--check status, for public or private-->
                                    <c:if test="${course.getStatus()}">
                                        <label><i id="icon_public" class="fa fa-unlock-alt"></i> Public</label>
                                    </c:if>
                                    <c:if test="${course.getStatus() eq 'False'}">
                                        <label><i id="icon_private" class="fa fa-lock"></i> Private</label>
                                    </c:if>    
                                    <label class ="authorName">Author: <c:out value="${course.getUser().getName()}"/></label>
                                </div>
                            </c:forEach>
                        </form>
                         <ul class="pagination justify-content-center" id="pagination"></ul>
                            <input type='hidden' value='1' id ='page' name='page'>
                            <input type='hidden' value='<c:out value="${maxPageItems}"/>' id ='maxPageItems' name='maxPageItems'>
                            <input type="hidden" id='searchName' value="" name="nameForSearch">
                            <input type="hidden" id='courseFor' value="" name="courseFor">
                            <input type="hidden" id='blockedStatus' value="" name="blockedStatus">
                            <input type='hidden' value="${userid}" id ='userid' name='userid'>
                    </div>
                </div>
            </div>
        </div>

        <script>
            var alertMessage = "${alertMessage}";
            if (alertMessage) {
                alert(alertMessage);
            }
        </script>
        <script type="text/javascript">
            var totalPages = ${coursePagination.getTotalPage()};
            var currentPage = ${coursePagination.getPage()};
            var maxPageItems = 6;
            var searchName = '${nameForSearch}';
            console.info("currentPage : " + currentPage);
//            var limit = 5; //number of items on a page
//            var currentPage = 1;
            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    visiblePages: 5,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        console.info(page + ' (from options)');
                        //
                        if (currentPage !== page) {
                            $('#page').val(page);
                            if (searchName) {
                                $('#search').val(searchName);
                            }
                            $('#maxPageItems').val(maxPageItems);
                            $('#formSubmit').submit();
                        }
                    }
                });
            });
        </script>
        <script>
            function ChangeList(){
                var select1 = document.getElementById('listuser');
                var value1 = select1.options[select1.selectedIndex].value;
                document.getElementById("tempt").href = 'user-attend-course-Admin?userid='+value1;
                document.getElementById("tempt").click();
            }
        </script>
        
    </body>
</html>
