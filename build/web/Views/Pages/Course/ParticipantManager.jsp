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
        <link rel="stylesheet" type="text/css" href="Views/CSS/ParticipantManager.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title><c:out value="${course.getName()}"/></title>

    </head>
    <body>


        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div id='div_functionName'>
                    <label id='functionName'><c:out value='${course.getName()}'/></label>
                </div>
            </div>

            <div class ='main'>
                <div class ='nav'><!--navigation buttons-->
                    <div class ='user_info'>

                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-user">My Course></a>
                        <a href="detail-course?courseid=${course.getId()}"><c:out value="${course.getName()}"/>></a>
                        <a href="manage-participants?courseid=${course.getId()}">Participants></a>        
                    </div>

                    <div class='content_wrap'>
                        <button><a href = "manage-participants?courseid=${course.getId()}" id="link_show_participants">Participants</a></button>
                        <button> <a href="#" id="link_show_tests">Tests</a></button>
                        <br>
                        
                        <form id="search_form" action="manage-participants" method="GET">
                            <input id ="input_search" name="searchName" value ="<c:out value='${searchName}'/>" >
                            <input type="hidden" id='courseid' value="${course.getId()}" name="courseid">
                            <input type="submit" id="search_button" value="Search">
                            <a href = "add-participants?start=1&courseid=${course.getId()}" id="link_add_participant"><i id="icon_add" class="fa fa-plus-circle">Add participants</i></a>
                        </form>
                        
                        <c:if test='${not empty errorMessage}'>
                        <br><label id="errorMessage"><c:out value="${errorMessage}"/></label> 
                        </c:if>
                        
                        <form id="formSubmit"  action="manage-participants" method="GET">                      
                            <table id="course" class="table table-bordered table table-hover" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th class ='table_name_header'>Name</th>
                                        <th class ='table_delete_header'>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${not empty participantPagination}">
                                        <c:forEach var='item' items='${participantPagination.getEntityList()}'>
                                            <tr>
                                                <td class="table_name"><c:out value="${item.getName()}"/></td>

                                                <td class = "table_delete">
                                                    <i class='fa fa-user-times' onclick="deleteFunction('${item.getName()}', ${item.getId()}, ${course.getId()})"></i>
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
                            <input type="hidden" id='courseid' value="${course.getId()}" name="courseid">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var message = "${message}";
            if(message){
                alert(message);
            }
            function deleteFunction(username, userid, courseid) {
                if (confirm("Are you sure you want to delete " + username +"?")) {
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
    </body>
</html>
