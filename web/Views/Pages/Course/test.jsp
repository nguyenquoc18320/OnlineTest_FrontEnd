<%-- 
    Document   : test
    Created on : Oct 25, 2021, 12:37:18 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <nav aria-label="Page navigation">
                <ul class="pagination" id="pagination"></ul>
            </nav>
        </div>
        <script type="text/javascript">
            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: 35,
                    visiblePages: 10,
                    onPageClick: function (event, page) {
                        console.info(page + ' (from options)');
                    }
                }).on('page', function (event, page) {
                    console.info(page + ' (from event listening)');
                });
            });
        </script>
    </body>
</html>
