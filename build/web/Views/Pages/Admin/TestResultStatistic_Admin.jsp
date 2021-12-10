<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <link rel="stylesheet" type="text/css" href="Views/CSS/User/ScoreStatisticForAuthor.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.min.js"></script>
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
                        <img alt="No Image" src='uploads/<c:out value="${user.getImage()}"/>'>
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
                        <a href="detail-course-admin?courseid=${test.getCourse().getId()}"><c:out value="${test.getCourse().getName()}"/>></a>
                        <a href="test-detail-admin?testid=${test.getId()}"><c:out value="${test.getName()}"/>></a>
                        <a href="test-result-statistic-admin?testid=${test.getId()}">Statistic></a>                
                    </div>

                    <div class='content_wrap'>
                        <label id ='label_function_name'><c:out value="${test.getName()}"/></label>
                        <div id="div_">
                            <div id='div_chart'>
                                <canvas id="canvas" height="400" width="400"></canvas>
                            </div>
                            <div id="div_chart">
                                <canvas id="doughnut_canvas" height="400" width="400"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var resultList = ${resultList};
        var chart = document.getElementById('canvas').getContext('2d');
        var myBarChart = new Chart(chart, {
            type: 'bar',
            data: {
                labels: ['0-1', '1-2', '2-3', '3-4', '4-5', '5-6', '6-7', '7-8', '8-9', '9-10'],
                datasets: [{
                        label: '#Users',
                        data: resultList,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
//                            'rgba(54, 162, 235, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
//                            'rgba(54, 162, 235, 1)'

                        ],
                        borderWidth: 1
                    }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });


        var doughnut_chart = document.getElementById('doughnut_canvas').getContext('2d');
        var myDoughnutChart = new Chart(doughnut_chart, {
            type: 'doughnut',
            data: {
                labels: ['0-1', '1-2', '2-3', '3-4', '4-5', '5-6', '6-7', '7-8', '8-9', '9-10'],
                datasets: [{
                        label: '#Users',
                        data: resultList,
                        backgroundColor: [
                            'rgb(255, 99, 132)',
                            'rgb(54, 162, 235)',
                            'rgb(255, 205, 86)',
                            'rgb(255, 106, 106)',
                            'rgb(238, 121, 66)',
                            'rgb(250, 128, 144)',
                            'rgb(216, 191, 216)',
                            'rgb(171, 130, 255)',
                            'rgb(0, 128, 128)',
                            'rgb(0, 238, 118)',
                        ],
//                        borderColor: [
//                            'rgba(255, 99, 132, 1)',
//                            'rgba(54, 162, 235, 1)'
//
//                        ],
                        borderWidth: 1
                    }]
            }

        });


    </script>
</html>
