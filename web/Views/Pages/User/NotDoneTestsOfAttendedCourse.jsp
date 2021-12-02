<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/User/NotDoneTestsOfAttendedCourse.css" />
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
                    <label id='functionName' style="color: #4D4DFF"><c:out value="${course.getName()}"/></label>
                </div>
            </div>

            <div class ='main'>
                <div class ='nav'><!--navigation buttons-->
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
<!--                        <button><a href=""><i class="fas fa-splotch"></i> My Test Results </a></button>-->
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="attended-course">Attended Courses></a>
                        <a href="not-done-tests-attended-course?courseid=${course.getId()}"><c:out value="${course.getName()}"/>></a>
                        <a href="not-done-tests-attended-course?courseid=${course.getId()}">Not Done></a>
                    </div>

                    <div class='content_wrap'>
                        <a id='link_not_done' href='not-done-tests-attended-course?courseid=${course.getId()}'>Not Done</a>
                        <a id='link_done' href='done-tests?courseid=${course.getId()}'>Done</a>
                        <form id='formSubmit'action="attended-course" method="POST">
                            <c:forEach var="test" items="${testPagination.getEntityList()}">
                                <div class = "div_test">
                                    <a class ='testName' href="test-detail?testid=${test.getId()}"><c:out value="${test.getName()}"/></a><br>
                                    <!--check test open or not-->
                                    <c:choose>
                                        <c:when test="${(test.getStart() lt now) and (test.getend() gt now)}">
                                             <i class='fa fa-lock'>Closed</i>
                                        </c:when>
                                        <c:otherwise>
                                           <i class='fa fa-check'>Open</i>
                                        </c:otherwise>
                                    </c:choose>
                                           <br>
                                           <label class='label_description'> <c:out value="${test.getDescription()}"/> </label>   
                                </div>
                            </c:forEach>
                            
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
             var totalPages = ${testPagination.getTotalPage()};
             var currentPage = ${testPagination.getPage()};
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
             });
        </script>  
    </body>
</html>
