$(document).ready(function(){
   $('h3 + p').hide();
   $('h3').on('click', function(){
	  $(this).next('p').toggle();
   });
});
