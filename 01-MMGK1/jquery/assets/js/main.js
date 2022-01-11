//Query Test

$(document).ready(function (){

    let cookie = $("#cookie");
    cookie.animate({height: "120px", opacity: "1"}, "slow");

    $("#cookie-button").click(function() {
        cookie.animate({height: "0px", opacity: "0"}, "slow");
    });

    /*
    $("#cookie-button").click(function() {
        $("#cookie").slideToggle("slow");
    });
    */

    $("#scroll").click(function(){
        $("html, body").animate({scrollTop: 0}, 800);
        return false;
    });

});

$(window).scroll(function() {
    if($(this).scrollTop() > 100) {
        $("#scroll").fadeIn();
    } else {
        $("#scroll").fadeOut();
    }
});