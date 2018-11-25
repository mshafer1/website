
function expand(id, scrollId) {
    $('#' + id).removeClass('code-preview');
    $('#Btn' + id).html("Click to Collapse . . .").off("click");
    $('#Btn' + id).click(function () {
        collapse(id, scrollId);
    })
    console.log("ScrollID: " + scrollId);
    scrollToId(scrollId);
    console.log("expanding . . .");
}

function collapse(id, scrollId) {
    $('#' + id).addClass('code-preview')
    $('#Btn' + id).html("Click to Expand . . .").off("click");
    $('#Btn' + id).click(function () {
        expand(id, scrollId);
    })
    console.log("ScrollID: " + scrollId);
    scrollToId(scrollId);
    console.log("collapsing . . .");
}

function scrollToId(id) {
    $('html, body').animate({
        scrollTop: $('#' + id).offset().top - 50,
      }, 500)
}