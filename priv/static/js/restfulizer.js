/**
 * Taken from http://paste.laravel.com/b8n
 * and added a datum attr to submit data along with the RESTful request
 * 
 * Restfulize any hiperlink that contains a data-method attribute by
 * creating a mini form with the specified method and adding a trigger
 * within the link.
 * Requires jQuery!
 *
 * Ex in Laravel:
 *     <a href="users" data-method="delete" data-datum="2">destroy</a>
 *     // Will trigger the route Route::delete('users')
 * 
 */
$(function(){
    $('[data-method]:not(:has(form))').append(function(){
        return "\n"+
        "<form action='"+$(this).attr('href')+"' method='POST' style='display:none'>\n"+
        "   <input type='hidden' name='_method' value='"+$(this).attr('data-method')+"'>\n"+
        "   <input type='hidden' name='datum' class='datum' value='"+$(this).attr('data-datum')+"'>\n"+
        "</form>\n"
    })
    .removeAttr('href')
    .attr('style','cursor:pointer;')
    .attr('onclick','$(this).find("form").submit();');
});
