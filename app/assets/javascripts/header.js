$(function() {
    var toggleHeaderExpanded = function () {
        $('.header').toggleClass('header--collapsed');
    };

   $(document).on('click', '.header__clicky', toggleHeaderExpanded);
});
