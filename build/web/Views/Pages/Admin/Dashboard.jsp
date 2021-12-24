<%-- 
    Document   : CreateNewCourse
    Created on : Oct 15, 2021, 10:59:40 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />      
        <link rel="stylesheet" type="text/css" href="Views/CSS/Admin/Dashboard.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>Dashboard</title>
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
                        <button><a href="dashboard"><i class="fas fa-home"  style='background-color: #5531FB; color:white'></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                        <button><a href="manage-user"><i class="fas fa-users"></i>Manage users</a></button>
                        <button><a href="manage-course-admin"><i class="fas fa-book-open" ></i>Manage Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>
                <div class="div_all">
                    <label id="label_dashboard">Dashboard</label>
                    <div class="div_detail">
                        <div class="div_course">
                            <label id="label_course">Courses</label>
                            <div class='div_course_detail'>
                                <div class="div_total">
                                    Total
                                    <label class="label_info"><c:out value="${json.get('totalCourses')}"/></label>
                                </div>
                                <div class='div_status'>
                                    <div class='div_status_detail'>
                                        Public
                                        <label class="label_info"><c:out value="${json.get('totalPublicCourses')}"/></label>
                                    </div>
                                    <div class='div_status_detail'>
                                        Private
                                        <label class="label_info"><c:out value="${json.get('totalPrivateCourses')}"/></label>
                                    </div>
                                    <div class='div_status_detail'>
                                        Blocked
                                        <label class="label_info"><c:out value="${json.get('totalBlockedCourses')}"/></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='div_2'>
                            <div class='div_test'>
                                <label id="label_course">Tests</label>
                                <div class='div_test_detail'>
                                    <div class="div_test_total">
                                        Total
                                        <label class="label_info"><c:out value="${json.get('totalTests')}"/></label>
                                    </div>
                                    <div class='div_test_status'>                                       
                                        <div class='div_test_status_detail'>
                                            Open
                                            <label class="label_info"><c:out value="${json.get('totalOpenTests')}"/></label>
                                        </div>
                                        <div class='div_test_status_detail'>
                                            Closed
                                            <label class="label_info"><c:out value="${json.get('totalClosedTests')}"/></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class='div_user'>
                                <label id="label_course">Users</label>
                                <div class='div_user_detail'>
                                    <div class="div_test_total">
                                        Total
                                        <label class="label_info"><c:out value="${json.get('totalUsers')}"/></label>
                                    </div>
                                    <div class='div_user_status'>                                       
                                        <div class='div_user_status_detail'>
                                            Active
                                            <label class="label_info"><c:out value="${json.get('totalActiveUsers')}"/></label>
                                        </div>
                                        <div class='div_user_status_detail'>
                                            Disable
                                            <label class="label_info"><c:out value="${json.get('totalDisableUsers')}"/></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script type="text/javascript">
            var totalPages = ${coursePagination.getTotalPage()};
            var currentPage = ${coursePagination.getPage()};
            var maxPageItems = 5;
            var searchName = '${nameForSearch}';
            var searchAuthor = '${authorForSearch}';
            var courseFor = '${courseFor}';
            var blockedStatus = '${blockedStatus}';
            console.info("name : " + searchName);
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
                                $('#searchName').val(searchName);
                            }
                            if (searchAuthor) {
                                $('#searchAuthor').val(searchAuthor);
                            }
                            if (courseFor) {
                                $('#courseFor').val(courseFor);
                            }
                            if (courseFor) {
                                $('#blockedStatus').val(blockedStatus);
                            }
                            $('#maxPageItems').val(maxPageItems);
                            $('#formSubmit').submit();
                        }
                    }
                });

            });
        </script>
        <script src="Views/JS/base.js"></script>
    </body>
</html>
