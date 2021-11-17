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
        <link rel="stylesheet" type="text/css" href="Views/CSS/CourseManager_Admin.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
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
                    <label id='functionName'>Manage Course</label>
                </div>
            </div>

            <div class ='main'>
                <div class ='nav'><!--navigation buttons-->
                    <div class ='user_info'>

                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-admin">Manage Course></a>
                    </div>

                    <div class='content_wrap'>

                        <form id="form-search"  action="manage-course-admin" method="GET">
                            <div class ="div_1">   
                                
                                <c:choose>
                                    <c:when test="${blockedStatus eq 'Yes'}">
                                        <div>Blocked: <input type="radio" name="blockedStatus" value="NotUse"><label>Not use</label><br></div>
                                        <div><input type="radio" name="blockedStatus" value="Yes" checked><label>Yes</label><br></div>
                                        <div><input type="radio" name="blockedStatus" value="No"><label>No</label><br></div>
                                    </c:when>
                                    <c:when test="${blockedStatus eq 'No'}">
                                        <div>Blocked: <input type="radio" name="blockedStatus" value="NotUse"><label>Not use</label><br></div>
                                        <div><input type="radio" name="blockedStatus" value="Yes" ><label>Yes</label><br></div>
                                        <div><input type="radio" name="blockedStatus" value="No" checked><label>No</label><br></div>
                                    </c:when>
                                    <c:otherwise >
                                        <div>Blocked:<input type="radio" name="blockedStatus" value="NotUse" checked><label>Not use</label><br></div>
                                        <div><input type="radio" name="blockedStatus" value="Yes" ><label>Yes</label><br></div>
                                        <div><input type="radio" name="blockedStatus" value="No" ><label>No</label><br></div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class ="div_2">                             
                                <c:choose>
                                    <c:when test="${courseFor eq 'Public'}">
                                        <input type="radio" name="courseFor" value="All"><label>All</label><br>
                                        <input type="radio" name="courseFor" value="Public" checked><label>Public</label><br>
                                        <input type="radio" name="courseFor" value="Private"><label>Private</label><br>
                                    </c:when>
                                    <c:when test="${courseFor eq 'Private'}">
                                        <input type="radio" name="courseFor" value="All"><label>All</label><br>
                                        <input type="radio" name="courseFor" value="Public" ><label>Public</label><br>
                                        <input type="radio" name="courseFor" value="Private" checked><label>Private</label><br>
                                    </c:when>
                                    <c:otherwise >
                                        <input type="radio" name="courseFor" value="All" checked><label>All</label><br>
                                        <input type="radio" name="courseFor" value="Public" ><label>Public</label><br>
                                        <input type="radio" name="courseFor" value="Private" ><label>Private</label><br>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                            <div class ="div_3">
                                <label >Course Name:</label>
                                <input type="text" id='course_name_search' name="nameForSearch" 
                                       <c:if test="${not empty nameForSearch}">value="<c:out value='${nameForSearch}'/>"</c:if>>
                                       <button type ="submit" id ="search_button"><i class="fa fa-search" >Search</i></button> 
                                       <br/>
                                       <label> Author:</label>
                                       <input type="text" id="author_search" name="authorForSearch" <c:if test="${not empty authorForSearch}">value="<c:out value='${authorForSearch}'/>"</c:if>>
                                       <br/>
         
                                       <!--<a href = "create-course?start=1" id="link_create_course"><i id="icon_add" class="fa fa-plus-circle">New Course</i></a>-->
                                </div>
                            </form>             
                            <form id="formSubmit"  action="manage-course-admin" method="GET">                      
                                <table id="course" class="table table-bordered table table-hover" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th class ='table_name_header'>Name</th>
                                            <th class ='table_author_header'>Author</th>
                                            <th class ='table_public_header'>Public</th>
                                            <th class ='table_blocked_header'>Blocked</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${not empty coursePagination}">
                                        <c:forEach var='item' items='${coursePagination.getEntityList()}'>
                                            <tr>
                                                <td class="table_name"><c:out value="${item.getName()}"/></td>
                                                <td>
                                                    <c:out value="${item.getUser().getName()}"/>
                                                </td>
                                                <!--check status, for public or private-->
                                                <td class="table_check_icon">
                                                    <c:if test="${item.getStatus()}">
                                                        <i id="icon_check" class="fa fa-check-circle"></i>
                                                    </c:if>
                                                </td>

                                                <td class = "table_blocked">
                                                    <c:if test="${item.getBlocked()}">
                                                        <i id="icon_blocked" class="fa fa-ban"></i>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </tbody>
                            </table>

                            <ul class="pagination justify-content-center" id="pagination"></ul>
                            <input type='hidden' value='1' id ='page' name='page'>
                            <input type='hidden' value='<c:out value="${maxPageItems}"/>' id ='maxPageItems' name='maxPageItems'>
                            <input type="hidden" id='searchName' value="" name="nameForSearch">
                            <input type="hidden" id='searchAuthor' value="" name="authorForSearch">
                            <input type="hidden" id='courseFor' value="" name="courseFor">
                            <input type="hidden" id='blockedStatus' value="" name="blockedStatus">
                        </form>
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
//            }).on('page', function (event, page) {
//            console.info(page + ' (from event listening)');
//            });
            });
        </script>
    </body>
</html>