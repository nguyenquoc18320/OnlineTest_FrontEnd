<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="Views/CSS/BaseFormat.css" />
        <!--<link rel="stylesheet" type="text/css" href="Views/CSS/createNewCourse.css" />-->
        <link rel="stylesheet" type="text/css" href="Views/CSS/User/AttendTest.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
        <script   type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <!--<script charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>-->
        <script src="<c:url value='/Views/Template/jquery.twbsPagination.js'/>" type="text/javascript"></script>
        <title>Test Detail</title>
    </head>
    <body>
        <div class='wrap'>
            <div id = 'header'><!--Header includes the logo and name of function-->
                <div id='div_logo'>
                    <img id='logo' src="Views/CSS/images/logo1.png" alt="logo">
                </div>
                <div id='div_functionName'>
                    <label id='functionName' style="color: #4D4DFF"><c:out value="${test.getName()}"/></label>
                </div>
            </div>

            <div class ='main'>
                <div class ='navi'><!--navigation buttons-->
                    <div class ='profile'>
                        <img alt="No Image" src="uploads/<c:out value="${user.getImage()}"/>">
                        <p><c:out value=""/>${user.getName()}</p>
                        <p><c:out value=""/>${user.getEmail()}</p>
                    </div>
                    <div class="menu">
                        <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                        <button><a href="user-info"><i class="fas fa-address-book"></i> My Information</a></button>
                        <button><a href="attended-course"><i class="fas fa-users"></i>Attended Courses</a></button>
                        <button><a href="manage-course-user"><i class="fas fa-book-open"></i> My Courses </a></button>
                        <button><a href="log-out"><i class="fas fa-user"></i> LogOut</a></button>
                    </div>
                </div>
                <div class='content'>
                    <div class ="path_div">
                        <a href="attended-course">Attended Courses></a>
                        <a href="not-done-tests-attended-course?courseid=${test.getCourse().getId()}"><c:out value="${test.getCourse().getName()}"/>></a>
                        <a href="not-done-tests-attended-course?courseid=${test.getCourse().getId()}">Not Done></a>
                        <a href="test-detail?testid=${test.getId()}"><c:out value="${test.getName()}"/>></a>
                    </div>

                    <div class='content_wrap'>
                        <c:choose>
                            <c:when test="${not empty result}">
                                <form id='formSubmit'action="finish-test" method="POST">
                                    <input type='hidden' name='testid' value='<c:out value="${test.getId()}"/>'>
                                    <div class='div_answer'>
                                        <c:if test="${(questionList.size()-1) ge 0}">
                                            <c:forEach var="i" begin="0" end="${questionList.size()-1}">
                                                <label id='label_num_${i+1}' class='label_num' onclick='openQuestion(${i+1}, ${questionList.get(i).getId()})'><c:out value="${i+1}"/></label>
                                            </c:forEach><br>
                                        </c:if>
                                        End time: <label id='label_endTime'> <fmt:parseDate value="${result.get('endTime')}" var="date" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSZ"/>
                                            <fmt:formatDate value="${date}" pattern="HH:mm dd-MM-yyy "/></label>
                                        <p id='note'>You must submit your answers before end time.</p>
                                        <label id='label_submit' onclick='finish(${test.getId()})'>Finish</label>

                                    </div>
                                    <div class='div_question'>
                                        <c:if test="${(questionList.size()-1) ge 0}">
                                            <c:forEach var="i" begin="0" end="${questionList.size()-1}">
                                                <div id='div_question_${i+1}'>
                                                    <label class='label_question'><c:out value="Question ${questionList.get(i).getQuestionnumber()}: ${questionList.get(i). getContent()}"/></label>

                                                    <c:forEach var='j' begin='0' end="${questionList.get(i).getAnswerList().size()-1}">
                                                        <c:if test="${not empty questionList.get(i).getAnswerList().get(j)}">
                                                            <input id='question_${i+1}_answer_${j+1}' type="radio" name='answer_${i+1}' value='${j}'>
                                                            <label ><c:out value="${questionList.get(i).getAnswerList().get(j)}"/></label><br>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:forEach var="ans" items="${answerList}">
                                                        <c:if test="${ans[0] eq questionList.get(i).getId()}">
                                                            <script>
                                                                var rad = document.getElementById('question_${i+1}_answer_${ans[1]}');
                                                                rad.checked = true;
                                                                var label1 = document.getElementById('label_num_' + (${i+1}));
                                                                label1.style.backgroundColor = '#B3D9FF';
                                                            </script>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </c:forEach><br>
                                        </c:if>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <h2 style="color:red; font-weight: bold; text-align: center; margin-left: 100px;">TEST IS CLOSED</h2>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var currentQuestion = 1;
            var questionList = [
            <c:forEach items="${questionList}" var="hero">
                '<c:out value="${hero.getId()}" />',
            </c:forEach>
            ];

            var userid = '${user.getId()}';
            var ansCharacters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
            openQuestion(1);

            function openQuestion(num) {
                console.info("curr: " + currentQuestion);
                console.info("num: " + num);
                var radios = document.getElementsByName('answer_' + currentQuestion);
                for (var radio of radios)
                {
                    if (radio.checked) {
                        var label = document.getElementById('label_num_' + currentQuestion);
                        label.style.backgroundColor = '#B3D9FF';

                        console.info("ra: " + ansCharacters[radio.value]);
                        fetch("http://localhost:8081/answer?questionid=" + questionList[currentQuestion - 1]
                                + "&userid=" + userid + "&selection=" + ansCharacters[radio.value], {
                            method: 'PUT',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify("")
                        });

                    }
                }

                //open question
                var div;
                for (var i = 1; i <= 10; i++)
                {
                    div = document.getElementById("div_question_" + i);
                    if (div)
                        div.style.display = "none";
                }

                div = document.getElementById("div_question_" + num);
                div.style.display = "block";
                currentQuestion = num;
            }

            function finish(testid) {
                if (confirm("Are you sure you want to finish the test ?")) {
                    $('#formSubmit').submit();
                } else {

                }
            }

            //start

        </script>
    </body>
</html>
