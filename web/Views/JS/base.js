console.info("start");
var menuValue = localStorage.getItem('menuValue');
console.info("menuValue1: " + menuValue);

if(!menuValue){
    localStorage.setItem("menuValue", "none");
    menuValue = localStorage.getItem('menuValue');
    console.info("menuValue2: " + menuValue);
}
document.getElementById("header").style.display=menuValue;

function changeMenuDisplay() {
    var menu = document.getElementById("header");

    var display = menu.style.display;

    if (display === "none") {
        menu.style.display = "flex";
        localStorage.setItem("menuValue", "flex");
    } else {
        menu.style.display = "none";
        localStorage.setItem("menuValue", "none");
//        document.getElementById("main").disabled = true;
    }
}


function closeMenu() {
    var menu = document.getElementById("header");
    menu.style.display = "none";
    localStorage.setItem("menuValue", "none");
}


