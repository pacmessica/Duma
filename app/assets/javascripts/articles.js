
function updateCounters() {
  console.log("updating...")
  $("#study-words-count").html($(".study-word").length);
  $("#known-words-count").html($(".known-word").length);
  $("#new-words-count").html($(".word").length - $(".study-word").length - $(".known-word").length);
}


function toggleStudyKnownWord(){
  console.log(this)
  var wordId = this.dataset.wordid;
  var element = this;
  var known = element.classList.contains("known-word");

  $.ajax({
    type: "PATCH",
    complete: function(result) {
      if ( result.responseText === 'success' ) {
        $('[data-wordid=' + wordId + ']')
          .toggleClass("study-word")
          .toggleClass("known-word");
      }
      updateCounters();
    },
    url: "/words/"+ wordId,
    data: JSON.stringify({ known: !known }),
    contentType: "application/json",
    dataType: "json"
  });
};


$(document).ready(function() {
  $('.translation').hide();
  $('.study-word').on({
    mouseenter: function() {
      $(this).next('.translation').show();
    },
    mouseleave: function() {
      $(this).next('.translation').hide();
    }
  });




  $(".known-word").bind("click", toggleStudyKnownWord);
  $(".study-word").bind('click', toggleStudyKnownWord);
  updateCounters();
});
