<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/User/ResultsOfAuthorTest.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>Test Result</title>
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
                        <img alt="No Image" src='uploads/<c:out value="${user.getImage()}"/>'>
                        <div class='info'>
                            <p id='info_name'><c:out value=""/>${user.getName()}</p>
                            <p id='info_email'><c:out value=""/>${user.getEmail()}</p>
                        </div>
                    </div>
                    <div class="menu">
                        <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Profile</a></button>
                        <button><a href="attended-course"><i class="fas fa-users"></i>Attended Courses</a></button>
                        <button><a href="manage-course-user" ><i class="fas fa-book-open" style='background-color: #5531FB; color:white'></i> My Courses </a></button>
                        <button><a href="log-out"><i class="fas fa-sign-out-alt"></i> LogOut</a></button>
                    </div>
                </div>
            </div>

            <div class ='main'>

                <div class='content'>
                    <div class ="path_div">
                        <i class="fa fa-bars" onclick="changeMenuDisplay()"></i>
                        <a href="manage-course-user">My Course></a>
                        <a href="detail-course?courseid=${test.getCourse().getId()}"><c:out value="${test.getCourse().getName()}"/>></a>                        
                        <a href="show-result-author-test?testid=${test.getId()}"><c:out value="${test.getName()}"/>></a>                        
                    </div>

                    <div class='content_wrap'>                     
                        <form id='formSubmit'action="show-result-author-test" method="POST">
                            <input hidden="" name="testid" value="<c:out value='${test.getId()}'/>">
                            <h3 id='testName'><c:out value="${test.getName()}"/></h3>
                            <div id='div_link_statistic'>
                                <a href="score-statistic?testid=${test.getId()}"><input id='btn_statistic' type='button' value='Statistic'></a>
                                <a href="#"><input id='btn_download_result' type='button' value='Download result' onclick="downloadResult(${user.getId()}, ${test.getId()})"></a>
                            </div>
                            <c:forEach var="result" items="${resultPagination.getEntityList()}">
                                <div class="div_result">
                                    <label class='label_name'><c:out value="${result.getUser().getName()}"/> </label>
                                    <label class='label_email'>(<c:out value="${result.getUser().getEmail()}"/>)</label><br>
                                    Score: <label class='label_score'><c:out value="${result.getScore()}"/></label>
                                </div>
                            </c:forEach>

                            <ul class="pagination justify-content-center" id="pagination"></ul>
                            <input type='hidden' value='1' id ='page' name='page'>
                            <input type='hidden' value='<c:out value="${maxPageItems}"/>' id ='maxPageItems' name='maxPageItems'>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var totalPages = ${resultPagination.getTotalPage()};
            var currentPage = ${resultPagination.getPage()};
            var maxPageItems = 5;

            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    visiblePages: 5,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        if (currentPage !== page) {
                            $('#page').val(page);
                            $('#maxPageItems').val(maxPageItems);
                            $('#formSubmit').submit();
                        }
                    }
                });
            });
            
            function downloadResult(userid, testid){
                 document.location.href = "http://localhost:8081/test-result/export?authorid=" + userid + "&testid=" + testid;
            }
        </script>
        <script src="Views/JS/base.js"></script>
    </body>
</html>
