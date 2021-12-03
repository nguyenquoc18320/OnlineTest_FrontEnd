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
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/CourseManager_user.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>My course</title>
    </head>
    <body>
        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div id='div_functionName'>
                    <label id='functionName'>My Course</label>
                </div>
            </div>

            <div class ='main'>
                <div class ='navi'><!--navigation buttons-->
                    <div class ='profile'>
                        <img alt="No Image" src="uploads/<c:out value="${User.getImage()}"/>">
                        <p><c:out value=""/>${user.getName()}</p>
                        <p><c:out value=""/>${user.getEmail()}</p>
                    </div>
                    <div class="menu">
                        <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                        <button><a href="attended-course"><i class="fas fa-users"></i>Attended Courses</a></button>
                        <button><a href="manage-course-user"><i class="fas fa-book-open"></i> My Test Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-user">My Course></a>
                    </div>

                    <div class='content_wrap'>
                        <a href = "create-course?start=1" id="link_create_course"><i id="icon_add" class="fa fa-plus-circle">New Course</i></a>
                        <form id="form-search"  action="manage-course-user" method="GET">
                            <input type="text" id='search_input' name="nameForSearch" 
                                   <c:if test="${not empty nameForSearch}">value="<c:out value='${nameForSearch}'/>"</c:if>>
                                   <button type ="submit" id ="search_button"><i class="fa fa-search" >Search</i></button> 
                            </form>             
                            <form id="formSubmit"  action="manage-course-user" method="GET">                      
                                <table id="course" class="table table-bordered table table-hover" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th class ='table_name_header'>Name</th>
                                            <th class ='table_public_header'>Public</th>
                                            <th class ='table_edit_header'></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${not empty coursePagination}">
                                        <c:forEach var='item' items='${coursePagination.getEntityList()}'>
                                            <tr>
                                                <td class="table_name">
                                                    <c:choose>
                                                        <c:when test="${item.getBlocked()}">
                                                            <c:out value="${item.getName()}"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a class="course-name" href="detail-course?courseid=${item.getId()}"><c:out value="${item.getName()}"/></a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <!--check status, for public or private-->
                                                <td class="table_check_icon">
                                                    <c:if test="${item.getStatus()}">
                                                        <i id="icon_check" class="fa fa-check-circle"></i>
                                                    </c:if>
                                                </td>

                                                <td class = "table_edit">
                                                    <!--check whether the course is blocked or not-->
                                                    <c:choose>
                                                        <c:when test="${item.getBlocked()}">
                                                            <label>Blocked</label>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="edit-course?start=1&courseid=<c:out value='${item.getId()}'/>" ><i class='fa fa-edit'></i></a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </tbody>
                            </table>

                            <ul class="pagination justify-content-center" id="pagination"></ul>
                            <input type='hidden' value='1' id ='page' name='page'>
                            <input type='hidden' value='<c:out value="${maxPageItems}"/>' id ='maxPageItems' name='maxPageItems'>
                            <input type="hidden" id='search' value="" name="nameForSearch">
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <script>
            //delete message
            var message = "${deleteMessage}";
            if (message) {
                alert(message);
            }
        </script>

        <script type="text/javascript">
            var totalPages = ${coursePagination.getTotalPage()};
            var currentPage = ${coursePagination.getPage()};
            var maxPageItems = 5;
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
//            }).on('page', function (event, page) {
//            console.info(page + ' (from event listening)');
//            });
            });
        </script>
    </body>
</html>
