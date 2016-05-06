$(document).ready(function(){
   $('h3 + p').hide();
   $('h3').on('click', function(){
	  $(this).next('p').toggle();
   });

   $('button').on('click', function(){
     var wordId = this.dataset.wordid;
     var button = this;
     $.ajax({
      type: "PATCH",
      async: true,
      complete: function(result) {
        console.log(result)
        if ( result.responseText === 'success' ) {
          console.log($(button).parent().parent().remove());
        }
      },
      url: "/words/"+ wordId,
      data: JSON.stringify({ known: true }),
      contentType: "application/json",
      dataType: "json"});
   });
});
