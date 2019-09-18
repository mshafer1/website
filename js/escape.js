// utitilty functions to escape raw code to valid html

function escape_html(raw) {
    var result = raw;

    itemsToReplace = {
        '<': "&lt;",
        '>': "&gt;",
    }

    for (var key in itemsToReplace) {
        result = result.replaceAll(key, itemsToReplace[key])
    }

    return result
}

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};