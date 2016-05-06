$(document).ready(function(){
   $('.word-name').on('click', function(){
     $(this).next('.translation-form').toggle();
   });
   $('.translation-form').hide();

   $('#add-to-known').on('click', function(){
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
