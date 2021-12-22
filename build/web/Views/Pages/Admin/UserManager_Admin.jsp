<%-- 
    Document   : UserManager_Admin
    Created on : Dec 9, 2021, 1:02:58 AM
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
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/Admin/UserCourse_Admin.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
        <link href="Views/CSS/su/test.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/su/login.css" />
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>User Manager</title>
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
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                        <button><a href="manage-user"><i class="fas fa-users"></i>Manage users</a></button>
                        <button><a href="manage-course-admin"><i class="fas fa-book-open"></i>Manage Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-admin">Manage User></a>
                    </div>
                    
                    <div class='content_wrap'>

                        <form id="form-search"  action="manage-user?start=2" method="POST">
                            <input type='hidden' value="${userid}" id ='userid' name='userid'>
                            <div>
                                <select id="typeuser" name="typeuser" class="cbb_listcourseresult" onchange="ChangeList()">                               
                                    <option value='0' <c:if test="${type eq '0'}"> selected="selected"</c:if> >All</option>
                                    <option value='1' <c:if test="${type eq '1'}"> selected="selected"</c:if> >Admin</option>
                                    <option value='2'<c:if test="${type eq '2'}"> selected="selected"</c:if> >User</option>                                  
                                </select>
                                <select id="statususer" name="statususer" class="cbb_listcourseresult" onchange="ChangeList()">                               
                                    <option value='0' <c:if test="${status eq '0'}"> selected="selected"</c:if>>All</option>
                                    <option value='1'<c:if test="${status eq '1'}"> selected="selected"</c:if>>Block</option>
                                    <option value='2'<c:if test="${status eq '2'}"> selected="selected"</c:if>>Unblock</option>                                  
                                </select>
                                <a id="tempt"></a>
                            </div>
                            <div class ="div_3">
                                <input type="text" id='course_name_search' class="btn_search" name="nameForSearch" placeholder="Enter User Name">
                                <button type ="submit" id ="search_button"><i class="fa fa-search" >Search</i></button> 
                                <br/>
                            </div>
                        </form>             
<!--                        <form id="formSubmit"  action="user-course-admin" method="POST">                      -->
                            <table id="course" class="table table-bordered table table-hover" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th style="text-align: center;"> ID </th>
                                        <th style="text-align: center;">Name</th>
                                        <th class ='table_public_header'>Email</th>
                                        <th class ='table_blocked_header' style="text-align: center;">Status</th>
                                        <th style="text-align: center;"> Role </th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:if test="${not empty userList}">
                                    <c:forEach var='item' items='${userList}'>
                                        <tr>
                                            <td style="text-align: center;"><button onclick="togglePopup()"> <c:out value="${item.getId()}"/></button></td>

                                            <div class="popup" id="popup-1">
                                                <div class="overlay"></div>
                                                <div class="contentpopup">
                                                    <div class="close-btn" onclick="togglePopup()">&times;</div>
                                                    <h4>Profile</h4>
                                                    <div class="squareFrame">
                                                        <img src="uploads/<c:out value="${item.getImage()}"/>" />
                                                    </div>
                                                    <div>
                                                        <p>Name: <c:out value="${item.getName()}"/></p>
                                                        <p>Date of Birth: <c:out value="${item.getDateOfBirth()}"/></p>
                                                        <p>Gender: <c:out value="${item.getGender()}"/><p>
                                                        <p>Email: <c:out value="${item.getEmail()}"/></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <td class="table_name">
                                                <c:if test="${item.getRole().getId() eq '2'}">
                                                     <a href="user-attend-course-Admin?userid=${item.getId()}" ><c:out value="${item.getName()}"/></a>
                                                </c:if>
                                               <c:if test="${item.getRole().getId() eq '1'}">
                                                     <a href="#" ><c:out value="${item.getName()}"/></a>
                                                </c:if>
                                            </td>
                                            <td class="table_name"><c:out value="${item.getEmail()}"/></td>
                                        
<!--                                        <td class="table_check_icon">
                                        <c:if test="${item.getEmail()}">
                                            <i id="icon_check" class="fa fa-check-circle"></i>
                                        </c:if>
                                        </td>-->
                                            
                                        <td class = "table_blocked">
                                            <c:choose>
                                                <c:when test="${item.isStatus()}">
                                                    <a href="block-unblock-user?userid=${item.getId()}"> <i id="icon_unblocked" class="fa fa-unlock"></i></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="block-unblock-user?userid=${item.getId()}"> <i id="icon_blocked" class="fa fa-lock"></i> </a>
                                                    </c:otherwise>
                                                </c:choose>
                                        </td>
                                        <td>
                                            <c:out value="${item.getRole().getName()}"/>
                                        </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                </tbody>
                            </table>                          
                        <!--</form>-->
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
        <script>
            function ChangeList(){
                var select1 = document.getElementById('typeuser');
                var value1 = select1.options[select1.selectedIndex].value;
                var select2 = document.getElementById('statususer');
                var value2 = select2.options[select2.selectedIndex].value;
                document.getElementById("tempt").href = 'manage-user?type='+value1+'&status='+value2+'&start=1';
                document.getElementById("tempt").click();
            }
        </script>
        <script>
            function togglePopup(){
                document.getElementById("popup-1").classList.toggle("active")
            }
        </script>
        
    </body>
</html>

