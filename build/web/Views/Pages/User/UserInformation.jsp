<%-- 
    Document   : UserInformation
    Created on : Oct 26, 2021, 2:46:03 PM
    Author     : PhanSu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
     <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" integrity="sha512-d9xgZrVZpmmQlfonhQUvTR7lMPtO7NkZMkA0ABN3PHCbKA5nqylQ/yWlFAyY6hYgdF1Qh6nYiuADWwKB4C2WSw==" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/common.css" rel="stylesheet" type="text/css"/>
    <script src="Views/JS/user.js"></script>
    <title>User</title>
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
                    <c:if test = "${user.getRole().getId() eq '1'}">
                       <div class="menu">
                            <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                            <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                            <button><a href="#"><i class="fas fa-users"></i>Manage users</a></button>
                            <button><a href="manage-course-admin"><i class="fas fa-book-open"></i>Manage Courses </a></button>
                            <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                            <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                        </div>
                    </c:if>
                    <c:if test = "${user.getRole().getId() eq '2'}">    
                        <div class="menu">
                            <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                            <button><a href="user-info"><i class="fas fa-address-book" style='background-color: #5531FB; color:white'></i> My Profile</a></button>
                            <button><a href="attended-course"><i class="fas fa-users"></i>Attended Courses</a></button>
                            <button><a href="manage-course-user" ><i class="fas fa-book-open"></i> My Courses </a></button>
                            <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                            <button><a href="log-out"><i class="fas fa-sign-out-alt"></i> LogOut</a></button>
                        </div>
                    </c:if>
                </div>
            </div>
            
        <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <a href="user-info">My Profile></a>
                    </div>
<!--        <div class="wrapped">
            <div class="nav-bar">
                <h1>Information</h1>
                <div class="drop-down" id="drop-down-user">
                    <a href="/Views/Pages/User/Login.jsp"><button>Log Out</button></a>
                </div>
                <i class="fas fa-user-circle" onclick="ToggleDropDown('drop-down-user')"></i>
            </div>
            <div class="content">-->
                <div class="introduce-profile lagre">
                    <div class="title-profile">
                        <p>My Profile</p>
                        <div class="drop-down setting" id="drop-down-setting">
                            <button><a href="update-info">Change Personal Information</a></button>
                            <button><a href="change-pass?start=1">Change Password</a></button>
                        </div>
                        <i class="fas fa-cog" id="setting" onclick="ToggleDropDown('drop-down-setting')"></i> 
                    </div>
                    <div class="info-profile">
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Name: </p>
                            <p class="describe">${user.getName()}</p>
                        </div>
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Date of Birth: </p>
                            <p class="describe">${user.getDateOfBirth()}</p>
                        </div>
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Gender: </p>
                            <p class="describe">${user.getGender()}</p>
                        </div>
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Email: </p>
                            <p class="describe">${user.getEmail()}</p>
                        </div>
                        
                    </div>
                </div>
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
</body>
</html>
