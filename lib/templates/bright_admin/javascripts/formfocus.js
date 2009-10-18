$(document).ready(function() {
	$('input[type="text"],input[type="password"],input[type="checkbox"],input[type="radio"],select,textarea').focus(function() {
		$(this).parent("li").addClass("focusField");
    });
    $('input[type="text"],input[type="password"],input[type="checkbox"],input[type="radio"],select,textarea').blur(function() {
    	$(this).parent("li").removeClass("focusField")
    });
   $("form.formtastic fieldset ol li:nth-child(odd)").addClass("odd");

});      

