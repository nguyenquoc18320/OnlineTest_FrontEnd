<%-- 
    Author     : PhanSu
--%>
<%@page import="Object.Question"%>
<%@page import="java.util.List"%>
<%@page import="Object.Test"%>
<%@page import="Object.User"%>
<%--<%@page import="Object.Course"%>
<%@page import="Object.Test"%>--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" integrity="sha512-d9xgZrVZpmmQlfonhQUvTR7lMPtO7NkZMkA0ABN3PHCbKA5nqylQ/yWlFAyY6hYgdF1Qh6nYiuADWwKB4C2WSw==" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="Views/CSS/su/user.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/test.css" rel="stylesheet" type="text/css"/>
    <link href="Views/CSS/su/common.css" rel="stylesheet" type="text/css"/>
    <script src="Views/JS/user.js"></script>
    <title>Question</title>
</head>
<body>
    <div class="container-full">
        <div class="side-bar">
            <div class="logo">
                <img src="Views/CSS/images/logo1.png">
            </div>
            <div class="profile">
                <img alt="No Image" src="uploads/<c:out value="${user.getImage()}"/>">
                <p><c:out value=""/>${user.getName()}</p>
                <p><c:out value=""/>${user.getEmail()}</p>

            </div>

            <div class="menu">
                <button><a href="Home"><i class="fas fa-home"></i>Home</a></button>
                <button><a href="UserInformation"><i class="fas fa-address-book"></i> My Information</a></button>
                <button><a href="list-test?start=1"><i class="fas fa-users"></i> Test Courses</a></button>
                <button><a href="manage-course-user"><i class="fas fa-book-open"></i> My Test Courses </a></button>
                <button><a href="add-question?start=1"><i class="fas fa-splotch"></i>Result </a></button>
                <button><a href=""><i class="fas fa-user"></i> LogOut</a></button>
            </div>
        </div>
        <div class="wrapped">
            <div class="nav-bar">
                <h1>Question</h1>
                <div class="drop-down" id="drop-down-user">
                    <a href=""><button>Log Out</button></a>
                </div>
                <i class="fas fa-user-circle"></i>
            </div>
            <form  action="add-question?testid=<c:out value="${Test.getId()}"/>" method="POST"> 
                <div id="content" class="content"> 
                    <h2 class="h2-aq">${Course.getName()}</h2>
                    <h3 class="he-aq">${Test.getName()}</h3>
                    <%--<c:forEach var = 'item' items='${listQuestion}'>--%>
                    <div id="question_1" class="border-addquestion" >
                        <p id="p0_question1">
                        <h4 id="question_number_1" name="question_number_1" class="number-question" > Question 1</h4>
                        <input id ="intput_question_number_1" name="intput_question_number_1"  type="text" class="input-number-question" value="1"/>
                        </p>
                        <p id="p1_question1">
                            <label for="contentQuestion1" id="content_question1" class="label_Question" data-icon="e" > Content:</label>
                            <textarea id="contentQuestion1" class="text_textarea" name = 'contentQuestion1' required ></textarea><br>  
                        </p>
                        <p id="p2_question1">
                            <label for="correctQ1" id="correct_question1" class="label_Question" data-icon="e" > Correct Answer: </label>
                            <select id="correctQ1" name="correctQ1" class="cbb_testQ">                               
                                <option id="optioncbbA_question1" value="A" selected="selected" >Option A</option>
                                <option id="optioncbbB_question1" value="B">Option B</option>
                            </select>
                        </p>                       
                        <p id="p3_question1">
                            <label  id="option1_question1" class="label_Question" data-icon="e" > Option A: </label>
                            <input id="a_question1" name="a_question1" class="optionQ" ></input>
                        </p>
                        <p id="p4_question1">
                            <label id="option1_question1" class="label_Question" data-icon="e" > Option B:</label>
                            <input id="b_question1" name="b_question1" class="optionQ" ></input>
                        </p>
                        <div id="option_question1">

                        </div>

                        <div id="plus-minus-question1" class="plus-minus">
                            <input type="button" id="addoption_question1" class="addoption" onclick="RemoveOption(1)"  value="Remove">
                            <input type="button" id="minusoptionplus_question1" class="minusoptionplus"  onclick="AddOption(1)" value="Add">
                        </div>
                        
                        <% Test testnow = (Test) request.getAttribute("Test");
                            request.setAttribute("testupdate", testnow);
                        %>
                        <script>

                            var totalOptions = 10;
                            var optionList = [];
                            //                        var questionList= [];
                            var totalOption = 2;
                            optionList[2] = 1;
                            for (var i = 0; i <= totalOptions; i++)
                            {
                                optionList.push(0);
                            }
                            var questionList2D = [];
                            var questionList1 = [];
                            var questionList2 = [];
                            for (var j = 0; j <= 50; j++)
                            {
                                questionList1[j] = j;
                                questionList2[j] = 3;
                            }
                            questionList2D.push(questionList1);
                            questionList2D.push(questionList2);

                            function AddOption(questionnumber)
                            {
                                //                            var emptyPosition = 0;
                                //                            var numberQuestion = questionList2D[0][questionnumber];
                                var numberOption = questionList2D[1][questionnumber];
                                //                            for (var i = 2; i <= totalOptions; i++)
                                //                            {
                                //                                if (optionList[i] === 0)
                                //                                {
                                //                                    emptyPosition = i;
                                //                                    break;
                                //                                }
                                //                            }

                                //                            if (emptyPosition === 0)
                                if (numberOption > 10)
                                {
                                    alert("Maximum 1 question only 10 answers !!");
                                    return;
                                }

                                //                            totalOption++;

                                var newOptopnP = document.createElement('p');
                                newOptopnP.setAttribute('id', 'addoption' + numberOption + '_question' + questionnumber);
                                document.getElementById('option_question' + questionnumber).appendChild(newOptopnP);
                                //                            optionList[emptyPosition] = 1;
                                questionList2D[1][questionnumber] = numberOption + 1;

                                var nameoption = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
                                var newLabelOption = document.createElement('p');
                                newLabelOption.setAttribute('id', 'option' + numberOption + '_question' + questionnumber);
                                newLabelOption.setAttribute('class', 'label_Question');
                                document.getElementById('addoption' + numberOption + '_question' + questionnumber).appendChild(newLabelOption);
                                document.getElementById('option' + numberOption + '_question' + questionnumber).innerHTML = 'Option ' + nameoption[numberOption - 1] + ':';

                                var newTextareaOption = document.createElement('input');
                                newTextareaOption.setAttribute('id', nameoption[numberOption - 1] + '_question' + questionnumber);
                                newTextareaOption.setAttribute('name', nameoption[numberOption - 1] + '_question' + questionnumber);
                                newTextareaOption.setAttribute('class', 'optionQ');
                                document.getElementById('addoption' + numberOption + '_question' + questionnumber).appendChild(newTextareaOption);

                                var newoptionCBB = document.createElement('option');
                                newoptionCBB.setAttribute('id', 'optionccb' + nameoption[numberOption - 1] + '_question' + questionnumber);
                                newoptionCBB.setAttribute('value', nameoption[numberOption - 1]);
                                document.getElementById('correctQ' + questionnumber).appendChild(newoptionCBB);
                                document.getElementById('optionccb' + nameoption[numberOption - 1] + '_question' + questionnumber).innerHTML = 'Option ' + nameoption[numberOption - 1];
                            }
                            function RemoveOption(questionnumber) {
                                var emptyPositionRemove = questionList2D[1][questionnumber] - 1;
                                if (emptyPositionRemove < 3)
                                {
                                    alert("Unable to continue deleting Options  !!");
                                    return;
                                }
                                //                            var emptyPositionRemove = 0;
                                //                            for (var i = 2; i <= totalOptions; i++)
                                //                            {
                                //                                if (optionList[i] === 0)
                                //                                {
                                //                                    emptyPositionRemove = i - 1;
                                //                                    break;
                                //                                }
                                //                            }

                                var nameoption = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
                                var dropoptionP = document.getElementById('addoption' + emptyPositionRemove + '_question' + questionnumber);
                                dropoptionP.parentNode.removeChild(dropoptionP);
                                questionList2D[1][questionnumber] = emptyPositionRemove;

                                var dropoptioncbb = document.getElementById('optionccb' + nameoption[emptyPositionRemove - 1] + '_question' + questionnumber);
                                dropoptioncbb.parentNode.removeChild(dropoptioncbb);
                            }
                        </script>
                    </div>
                    <%--</c:forEach>--%>
                    <c:if test="${not empty errorMessage}">
                        <label class="error"> <c:out value="${errorMessage}"/> </label>
                    </c:if>
                </div>
                <div class="buttton-new-question">
                    <input type="button" id="addquestion" class="newquestion" onclick="NewQuestion()"  value="New Question">
                    <input type="button" id="removequestion" class="newquestion" style="background: red;" onclick="RemoveQuestion()" value="Remove Question">
                </div>

                <Button type="submit"  class="completequestion" value="Complete"> Complete</Button>
            </form>
            <script>
                var totalQuestions = 50;
                var questionList = [];
                var totalQuestion = 0;
                questionList[1] = 1;
                for (var i = 0; i <= totalQuestions; i++)
                {
                    questionList.push(0);
                }
                <%
                    List<Question> listQ = (List<Question>) request.getAttribute("listQuestion");
                    int totalQuestion = (int) request.getAttribute("totalQuestion");
                    int total = 1;
                    if(totalQuestion>0){%>
                        RemoveQuestion();
                        questionList[1] = 0;
                    <%}
                %>

                <%for (int i = 1; i <= totalQuestion; i++) {%>

                    <%Question questionQ = listQ.get(i-1);%>
                    NewQuestion();
                    
                    document.getElementById('contentQuestion' + '<%=i%>').innerHTML = '<c:out value="<%=questionQ.getContent()%>"/>';
                    document.getElementById('a_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionA()%>"/>';
                    document.getElementById('b_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionB()%>"/>';

                    if(<%=questionQ.getOptionC() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('C_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionC()%>"/>';
                    }
                    if(<%=questionQ.getOptionD() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('D_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionD()%>"/>';
                    }
                    if(<%=questionQ.getOptionE() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('E_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionE()%>"/>';
                    }
                    if(<%=questionQ.getOptionF() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('F_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionF()%>"/>';
                    }
                    if(<%=questionQ.getOptionG() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('G_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionG()%>"/>';
                    }
                    if(<%=questionQ.getOptionH() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('H_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionH()%>"/>';
                    }
                    if(<%=questionQ.getOptionI() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('I_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionI()%>"/>';
                    }
                    if(<%=questionQ.getOptionJ() != null %>){
                      document.getElementById('minusoptionplus_question'+'<%=i%>').click();
                      document.getElementById('J_question' + '<%=i%>').value = '<c:out value="<%=questionQ.getOptionJ()%>"/>';
                    }
                    
                    selectElement('correctQ'+<%=i%>,'<%=(String)questionQ.getCorrectanswer()%>');

                <% }%>

                function NewQuestion() {
                    var temporary = 0;
                    
                    for (var i = 1; i <= totalQuestions; i++)
                    {
                        if (questionList[i] === 0)
                        {
                            temporary = i;

                            break;
                        }
                    }

                    if (temporary === 0)
                    {
                        alert("You can only add up to 50 questions !!!");
                        return;
                    }
                    //totalQuestion++;
                    var newQuestionDiv = document.createElement('div');
                    newQuestionDiv.setAttribute('id', 'question_' + temporary);
                    newQuestionDiv.setAttribute('class', 'border-addquestion');
                    document.getElementById("content").appendChild(newQuestionDiv);
                    questionList[temporary] = 1;

                    var newP4 = document.createElement('p');
                    newP4.setAttribute('id', 'p0_question' + temporary);
                    document.getElementById('question_' + temporary).appendChild(newP4);

                    var newQuestionNumber = document.createElement('h4');
                    newQuestionNumber.setAttribute('id', 'question_number_' + temporary);
                    newQuestionNumber.setAttribute('name', 'question_number_' + temporary);
                    newQuestionNumber.setAttribute('class', 'number-question');
                    newQuestionNumber.setAttribute('value', temporary);
                    document.getElementById('p0_question' + temporary).appendChild(newQuestionNumber);
                    document.getElementById('question_number_' + temporary).innerHTML = 'Question ' + temporary;

                    //<input id ="intput_question_number_1" name="intput_question_number_1"  type="text" class="input-number-question" value="1"/>

                    var newNumberQInput = document.createElement('input');
                    newNumberQInput.setAttribute('id', 'intput_question_number_' + temporary);
                    newNumberQInput.setAttribute('name', 'intput_question_number_' + temporary);
                    newNumberQInput.setAttribute('class', 'input-number-question');
                    newNumberQInput.setAttribute('type', 'text');
                    newNumberQInput.setAttribute('value', temporary);
                    document.getElementById('p0_question' + temporary).appendChild(newNumberQInput);
                    //p1
                    var newP1 = document.createElement('p');
                    newP1.setAttribute('id', 'p1_question' + temporary);
                    document.getElementById('question_' + temporary).appendChild(newP1);

                    var newLabelP1 = document.createElement('label');
                    newLabelP1.setAttribute('for', 'contentQuestion' + temporary);
                    newLabelP1.setAttribute('id', 'content_question' + temporary);
                    newLabelP1.setAttribute('class', 'label_Question');
                    document.getElementById('p1_question' + temporary).appendChild(newLabelP1);
                    document.getElementById('content_question' + temporary).innerHTML = 'Content:';
//  
                    var newTextarea = document.createElement('textarea');
                    newTextarea.setAttribute('id', 'contentQuestion' + temporary);
                    newTextarea.setAttribute('class', 'text_textarea');
                    newTextarea.setAttribute('name', 'contentQuestion' + temporary);
                    newTextarea.setAttribute('required', 'required');
                    document.getElementById('p1_question' + temporary).appendChild(newTextarea);
//                    newTextarea.setAttribute('value',);


                    //p2
                    var newP2 = document.createElement('p');
                    newP2.setAttribute('id', 'p2_question' + temporary);
                    document.getElementById('question_' + temporary).appendChild(newP2);
// 
                    var newLabelP2 = document.createElement('label');
                    newLabelP2.setAttribute('for', 'correctQ' + temporary);
                    newLabelP2.setAttribute('id', 'correct_question' + temporary);
                    newLabelP2.setAttribute('class', 'label_Question');
                    document.getElementById('p2_question' + temporary).appendChild(newLabelP2);
                    document.getElementById('correct_question' + temporary).innerHTML = 'Correct Answer:';

                    var newSelectQuesttion = document.createElement('select');
                    newSelectQuesttion.setAttribute('id', 'correctQ' + temporary);
                    newSelectQuesttion.setAttribute('name', 'correctQ' + temporary);
                    newSelectQuesttion.setAttribute('class', 'cbb_testQ');
                    document.getElementById('p2_question' + temporary).appendChild(newSelectQuesttion);

                    var newOptionA = document.createElement('option');
                    newOptionA.setAttribute('id', 'optioncbbA_question' + temporary);
                    newOptionA.setAttribute('value', 'A');
                    newOptionA.setAttribute('selected', 'selected');
                    document.getElementById('correctQ' + temporary).appendChild(newOptionA);
                    document.getElementById('optioncbbA_question' + temporary).innerHTML = 'Option A';
                    var newOptionB = document.createElement('option');
                    newOptionB.setAttribute('id', 'optioncbbB_question' + temporary);
                    newOptionB.setAttribute('value', 'B');
                    document.getElementById('correctQ' + temporary).appendChild(newOptionB);
                    document.getElementById('optioncbbB_question' + temporary).innerHTML = 'Option B';
                    //p3
                    var newP3 = document.createElement('p');
                    newP3.setAttribute('id', 'p3_question' + temporary);
                    document.getElementById('question_' + temporary).appendChild(newP3);

                    var newLabelP3 = document.createElement('label');
                    newLabelP3.setAttribute('id', 'option1_question' + temporary);
                    newLabelP3.setAttribute('class', 'label_Question');
                    document.getElementById('p3_question' + temporary).appendChild(newLabelP3);
                    document.getElementById('option1_question' + temporary).innerHTML = 'Option A:';

                    var newInputP3 = document.createElement('input');
                    newInputP3.setAttribute('id', 'a_question' + temporary);
                    newInputP3.setAttribute('class', 'optionQ');
                    newInputP3.setAttribute('name', 'a_question' + temporary);
                    document.getElementById('p3_question' + temporary).appendChild(newInputP3);
                    //p4
                    var newP4 = document.createElement('p');
                    newP4.setAttribute('id', 'p4_question' + temporary);
                    document.getElementById('question_' + temporary).appendChild(newP4);

                    var newLabelP4 = document.createElement('label');
                    newLabelP4.setAttribute('id', 'option2_question' + temporary);
                    newLabelP4.setAttribute('class', 'label_Question');
                    document.getElementById('p4_question' + temporary).appendChild(newLabelP4);
                    document.getElementById('option2_question' + temporary).innerHTML = 'Option B:';

                    var newInputP4 = document.createElement('input');
                    newInputP4.setAttribute('id', 'b_question' + temporary);
                    newInputP4.setAttribute('class', 'optionQ');
                    newInputP4.setAttribute('name', 'b_question' + temporary);

                    document.getElementById('p4_question' + temporary).appendChild(newInputP4);

                    var newSetOptionDiv = document.createElement('div');
                    newSetOptionDiv.setAttribute('id', 'option_question' + temporary);
                    document.getElementById('question_' + temporary).appendChild(newSetOptionDiv);

                    var newAddRemoveDiv = document.createElement('div');
                    newAddRemoveDiv.setAttribute('id', 'plus-minus-question' + temporary);
                    newAddRemoveDiv.setAttribute('class', 'plus-minus');
                    document.getElementById('question_' + temporary).appendChild(newAddRemoveDiv);

                    var newButtonRemove = document.createElement('input');
                    newButtonRemove.setAttribute('type', 'button');
                    newButtonRemove.setAttribute('id', 'addoption_question' + temporary);
                    newButtonRemove.setAttribute('class', 'addoption');
                    newButtonRemove.setAttribute('onclick', 'RemoveOption(' + temporary + ')');
                    newButtonRemove.setAttribute('value', 'Remove');
                    document.getElementById('plus-minus-question' + temporary).appendChild(newButtonRemove);

                    var newButtonAdd = document.createElement('input');
                    newButtonAdd.setAttribute('type', 'button');
                    newButtonAdd.setAttribute('id', 'minusoptionplus_question' + temporary);
                    newButtonAdd.setAttribute('class', 'minusoptionplus');
                    newButtonAdd.setAttribute('onclick', 'AddOption(' + temporary + ')');
                    newButtonAdd.setAttribute('value', 'Add');
                    document.getElementById('plus-minus-question' + temporary).appendChild(newButtonAdd);


                }
                function RemoveQuestion() {
                    var removeQuestion = 0;

                    for (var k = 2; k <= totalQuestions; k++)
                    {
                        if (questionList[k] === 0)
                        {
                            removeQuestion = k - 1;
                            break;
                        }
                    }
                    if (removeQuestion < 1)
                    {
                        alert("Unable to continue deleting Question  !!");
                        return;
                    }

                    var dropoptionP = document.getElementById('question_' + removeQuestion);
                    dropoptionP.parentNode.removeChild(dropoptionP);
                    questionList[removeQuestion] = 0;
                }
                function selectElement(id, valueToSelect) {    
                    let element = document.getElementById(id);
                    element.value = valueToSelect;
                }



//                document.write(countQ);
                //add question
                //totalQuestion = totalQuestion + (int)request.getAttribute("countQuestion");
//                if( 1>0)
//                {
//                    document.write(${countQuestion}+1);
//                    
//                    alert("count estions !!!");
////                    //NewQuestion();
//                    return;
////                    //totalQuestion--;
//                }


            </script>


        </div>
    </div>
</body>
</html>