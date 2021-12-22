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
        <link rel="stylesheet" type="text/css" href="Views/CSS/ParticipantManager.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>-->
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title><c:out value="${course.getName()}"/></title>

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
                        <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Profile</a></button>
                        <button><a href="attended-course"><i class="fas fa-users" ></i>Attended Courses</a></button>
                        <button><a href="manage-course-user" ><i class="fas fa-book-open" style='background-color: #5531FB; color:white'></i> My Courses </a></button>
                        <!--<button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-sign-out-alt"></i> LogOut</a></button>
                    </div>
                </div>
            </div>
            <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <i class="fa fa-bars" onclick="changeMenuDisplay()"></i>
                        <a href="manage-course-user">My Course></a>
                        <a href="detail-course?courseid=${course.getId()}"><c:out value="${course.getName()}"/>></a>
                        <a href="manage-participants?courseid=${course.getId()}">Participants></a>        
                    </div>

                    <div class='content_wrap'>
                        <div id='div_top'>
                            <label id ='label_function_name'><c:out value="${course.getName()}"/></label>
                            <div class="div_button"> 
                                <button id="btn_participants"><a href = "manage-participants?courseid=${course.getId()}" id="link_show_participants"><i class="fa fa-users">Participants</i></a></button>
                                <button id='btn_tests'> <a href="list-test?courseid=${course.getId()}" id="link_show_tests"><i class="fa fa-tasks">Test</i></a></button>
                                <button id='btn_add_participants'><a href = "add-participants?start=1&courseid=${course.getId()}" id="link_add_participant"><i id="icon_add" class="fa fa-plus-circle">Add participants</i></a></button>

                            </div>
                            <form id="search_form" action="manage-participants" method="GET">
                                <input id ="input_search" name="searchName" value ="<c:out value='${searchName}'/>" placeholder="Searching..." >
                                <input type="hidden" id='courseid' value="${course.getId()}" name="courseid">
                                <input type="submit" id="search_button" value="Search">

                            </form>
                        </div>

                        <c:if test='${not empty errorMessage}'>
                            <br><label id="errorMessage"><c:out value="${errorMessage}"/></label> 
                        </c:if>

                        <form id="formSubmit"  action="manage-participants" method="GET">                      
                            <c:if test="${not empty participantPagination}">
                                <c:forEach var='item' items='${participantPagination.getEntityList()}'>
                                    <div class ='div_user'>
                                        <div class='info_user'>
                                            <label class="label_name"><c:out value="${item.getName()}"/></label><br>
                                            <label class="label_email">(<c:out value="${item.getEmail()}"/>)</label>
                                        </div>
                                        <label class = "label_delete">
                                            <i class='fa fa-user-times' onclick="deleteFunction('${item.getName()}', ${item.getId()}, ${course.getId()})"></i>
                                        </label>
                                    </div>
                                </c:forEach>
                            </c:if>                      
                            <input type='hidden' value='1' id ='page' name='page'>
                            <input type='hidden' value='<c:out value="${maxPageItems}"/>' id ='maxPageItems' name='maxPageItems'>
                            <input type="hidden" id='search' value="" name="nameForSearch">
                            <input type="hidden" id='courseid' value="${course.getId()}" name="courseid">
                        </form>
                        <ul class="pagination justify-content-center" id="pagination"></ul>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var message = "${message}";
            if (message) {
                alert(message);
            }
            function deleteFunction(username, userid, courseid) {
                if (confirm("Are you sure you want to delete " + username + "?")) {
                    //                    console.info("OK");
                    document.location.href = "delete-joined-user?courseid=" + courseid
                            + "&userid=" + userid;
                } else {
                    //                    console.info("Cancel");
                }
            }
        </script>

        <script type="text/javascript">

            var totalPages = ${participantPagination.getTotalPage()};
            var currentPage = ${participantPagination.getPage()};
            var maxPageItems = 5;
            var searchName = '${nameForSearch}';
            //            console.info("name : " + searchName);
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
                ////            }).on('page', function (event, page) {
                ////            console.info(page + ' (from event listening)');
                ////            });
            });
            //delete a user in the course

        </script>
        <script src="Views/JS/base.js"></script>
    </body>
</html>
