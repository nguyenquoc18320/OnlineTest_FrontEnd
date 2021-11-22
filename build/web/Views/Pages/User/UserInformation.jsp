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
                <button><a href="UserInformation"><i class="fas fa-address-book"></i> My Information</a></button>
                <button><a href="list-test?start=1"><i class="fas fa-users"></i> Test Courses</a></button>
                <button><a href="Views/Pages/Test/CreateTest.jsp"><i class="fas fa-book-open"></i> My Test Courses </a></button>
                <button><a href="add-question?start=1"><i class="fas fa-splotch"></i> Add qs </a></button>
                <button><a href=""><i class="fas fa-user"></i> LogOut</a></button>
            </div>
        </div>
        <div class="wrapped">
            <div class="nav-bar">
                <h1>Information</h1>
                <div class="drop-down" id="drop-down-user">
                    <a href="account-profile"><button>Update Image</button></a>
                    <a href="sign-in"><button>Log Out</button></a>
                </div>
                <i class="fas fa-user-circle" onclick="ToggleDropDown('drop-down-user')"></i>
            </div>
            <div class="content">
                <div class="introduce-profile lagre">
                    <div class="title-profile">
                        <p>User Information</p>
                        <div class="drop-down setting" id="drop-down-setting">
                            <button><a href="update-info">Change Personal Information</a></button>
                            <button><a href="change-pass">Change Password</a></button>
                        </div>
                        <i class="fas fa-cog" id="setting" onclick="ToggleDropDown('drop-down-setting')"></i> 
                    </div>
                    <div class="info-profile">
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Name: </p>
                            <p class="describe">${User.getName()}</p>
                        </div>
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Date of Birth: </p>
                            <p class="describe">${User.getDateOfBirth()}</p>
                        </div>
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Gender: </p>
                            <p class="describe">${User.getGender()}</p>
                        </div>
                        <div class="info-detail-profile">
                            <p class="title-info-detail-profile">Email: </p>
                            <p class="describe">${User.getEmail()}</p>
                        </div>
                        
                    </div>
                </div>
            
        </div>
    </div>
</body>
</html>