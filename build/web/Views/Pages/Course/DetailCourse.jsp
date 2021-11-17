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
        <link rel="stylesheet" type="text/css" href="Views/CSS/DetailCourse.css" />
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
                    </div>

                    <div class='content_wrap'>
                        <button><a href = "manage-participants?courseid=${course.getId()}" id="link_show_participants">Participants</a></button>
                        <button> <a href="#" id="link_show_tests">Tests</a></button>
                        <br><label id="errorMessage"><c:out value="${errorMessage}"/></label> 
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
                                    <%--<c:if test="${not empty coursePagination}">--%>
                                        <%--<c:forEach var='item' items='${coursePagination.getEntityList()}'>--%>
                                            <!--<tr>-->
                                                <!--<td class="table_name"><c:out value="${item.getName()}"/></td>-->
                                                <!--check status, for public or private-->
                                                <!--<td class="table_check_icon">-->
                                                    <%--<c:if test="${item.getStatus()}">--%>
                                                        <!--<i id="icon_check" class="fa fa-check-circle"></i>-->
                                                    <%--</c:if>--%>
                                                <!--</td>-->

                                                <!--<td class = "table_edit">-->
                                                    <!--<a href="edit-course?start=1&courseid=<c:out value='${item.getId()}'/>" ><i class='fa fa-edit'></i></a>-->
                                                <!--</td>-->
                                            <!--</tr>-->
                                        <%--</c:forEach>--%>
                                    <%--</c:if>--%>
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


        <script type="text/javascript">
//            var totalPages = ${coursePagination.getTotalPage()};
//            var currentPage = ${coursePagination.getPage()};
//            var maxPageItems = 5;
//            var searchName = '${nameForSearch}';
//            console.info("name : " +searchName);
////            var limit = 5; //number of items on a page
////            var currentPage = 1;
//            $(function () {
//                window.pagObj = $('#pagination').twbsPagination({
//                    totalPages: totalPages,
//                    visiblePages: 5,
//                    startPage: currentPage,
//                    onPageClick: function (event, page) {
//                        console.info(page + ' (from options)');
//                        //
//                        if (currentPage !== page) {
//                            $('#page').val(page);
//                            if (searchName) {
//                                $('#search').val(searchName);
//                            }
//                            $('#maxPageItems').val(maxPageItems);
//                            $('#formSubmit').submit();
//                        }
//                    }
//                });
////            }).on('page', function (event, page) {
////            console.info(page + ' (from event listening)');
////            });
//            });
        </script>
    </body>
</html>
