/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



var SizePages = 10;

function ToggleDropDown(id)
{
    var front_div = document.getElementById(id);
    if (front_div !== null)
        if (front_div.style.display === 'flex')
        {
            front_div.style.display = 'none';
        }
        else
        {
            front_div.style.display = 'flex';
        }
}

function CloseFrontDiv(id)
{
    var front_div = document.getElementById(id);
    front_div.style.display = 'none';
//    window.location = "/new_online_course_web/admin";
}

function ShowFrontDiv(id)
{
    ToggleDropDown('drop-down-setting');
    var front_div = document.getElementById(id);
    front_div.style.display = 'flex';
}

function CloseFrontDivEditInfo()
{
    window.location = "/TestOnline/user-inf?isShowEditInfo=false";
}

function ShowFrontDivEditInfo()
{
    window.location = "/TestOnline/user-inf";//?isShowEditInfo=true";
}

function CloseFrontDivEditPass()
{
    window.location = "/TestOnline/user-inf";//?isShowEditPass=false";
}

function ShowFrontDivEditPass()
{
    window.location = "/TestOnline/user-inf?isShowEditPass=true";
}
//student
function CloseFrontDivEditInfoStudent()
{
    window.location = "/TestOnline/student?isShowEditInfo=false";
}

function ShowFrontDivEditInfoStudent()
{
    window.location = "/TestOnline/student?isShowEditInfo=true";
}

function CloseFrontDivEditPassStudent()
{
    window.location = "/TestOnline/student?isShowEditPass=false";
}

function ShowFrontDivEditPassStudent()
{
    window.location = "/TestOnline/student?isShowEditPass=true";
}

function SetMaxNumberPages(jsons){
    document.getElementById("numberOfPages").max = jsons.length / SizePages > parseInt(jsons.length / SizePages)? parseInt(jsons.length / SizePages) + 1 : parseInt(jsons.length / SizePages);
}