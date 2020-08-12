//custom JS scripts

//remove html spaces from quick search box to fix alignment
$(".searchBar").html(function (i, html) {
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
