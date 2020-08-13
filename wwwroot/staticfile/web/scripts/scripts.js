//custom JS scripts

//remove html spaces from quick search box to fix alignment
$(".searchBar").html(function (i, html) {
    return html.replace(/&nbsp;/g, '');
});

//remove html spaces from sidebar child categories
$(".sidebarContent .child").html(function (i, html) {
    return html.replace(/&nbsp;/g, '');
});

//show quick search on search icon navigation click
$( ".searchNav i" ).click(function() {
  $('.searchWrap').toggleClass('showSearch');
  $('.searchNav').toggleClass('searchOpen');
});

//show login nav on user icon click
$( ".loginNav i" ).click(function() {
  $('.navLoginWrap').toggleClass('showLogin');
  $('.loginNav').toggleClass('loginOpen');
});

//move sidebar login to the account top nav
$(".memberLoginWrap").appendTo(".navLoginWrap");

//move sidebar news info to a top announcement bar
$(".newsArea").appendTo(".announcement");

//move hero outside the content with sidebar area
$(".topHero").prependTo(".mainContent");

//limit top announcement text to 100 characters
$(".newsTxt p font").text(function(index, currentText) {
    return currentText.substr(0, 100);
});

//add class after scroll to header
$(window).scroll(function(){
    if ($(this).scrollTop() > 2) {
       $('.header').addClass('pageScrolled');
    } else {
       $('.header').removeClass('pageScrolled');
    }
});

//add class when sidebar sub categories are showing
$( ".sideBarContent .parent a:first-child" ).click(function() {
  $(this).toggleClass('exp');
});
