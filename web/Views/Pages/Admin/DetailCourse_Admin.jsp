<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/Admin/DetailCourse_Admin.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>My course</title>
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
                        <button><a href="#"><i class="fas fa-users"></i>Manage users</a></button>
                        <button><a href="manage-course-admin" ><i class="fas fa-book-open" style='background-color: #5531FB; color:white'></i>Manage Courses </a></button>
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>
                <div class='content'>
                    <div class ="path_div">
                        <a href="manage-course-admin">Manage Course></a>
                        <a href="detail-course-admin?courseid=${course.getId()}"><c:out value="${course.getName()}"/>></a>
                    </div>
                    <div class='content_wrap'>
                        <div id='div_top'>
                            <label id ='label_function_name'><c:out value="${course.getName()}"/></label>
                        </div>
                        <form id='formSubmit'action="detail-course-admin" method="POST">
                            <input type="hidden" name="courseid" value="${course.getId()}">
                            <c:forEach var="test" items="${testPagination.getEntityList()}">
                                <div class = "div_test">
                                    <a class ='testName' href="test-detail-admin?testid=${test.getId()}"><c:out value="${test.getName()}"/></a><br>
                                    <label class='label_description'> <c:out value="${test.getDescription()}"/> </label>  <br>
                                    <!--check test open or not-->
                                    <div class='div_status'>
                                        <a href='show-test-result-admin?testid=${test.getId()}'><label class='label_test_result'>Result</label></a>
                                        <c:choose>
                                            <c:when test='${test.isStatus() eq false}'>
                                                <label class='label_locked'><i class='fa fa-lock'></i>Locked</label>
                                            </c:when>
                                            <c:when test="${(test.getStart() gt now) or (test.getEnd() lt now)}">
                                                <label class='label_close'><i class='fa fa-lock'></i>Closed</label>
                                            </c:when>
                                            <c:otherwise>
                                                <label class='label_open'><i class='fa fa-unlock-alt'></i>Open</label>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                            <input type='hidden' value='1' id ='page' name='page'>
                            <input type='hidden' value='<c:out value="${maxPageItems}"/>' id ='maxPageItems' name='maxPageItems'>
                            <input type="hidden" id='search' value="" name="nameForSearch">
                        </form>

                        <ul class="pagination justify-content-center" id="pagination"></ul>
                    </div>
                </div>
            </div>
        </div>


        <script type="text/javascript">
            var totalPages = ${testPagination.getTotalPage()};
            var currentPage = ${testPagination.getPage()};
            var maxPageItems = 6;
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
