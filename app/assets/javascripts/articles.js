
function updateCounters() {
  var study_words = $(".study-word").map(function(index, element){
    // console.log(element.innerHTML)
    return element.innerHTML.toLowerCase();
  });
  console.log(study_words)
  study_words = jQuery.unique( study_words );
  console.log(study_words.length)
  $("#study-words-count").html($(".study-word").length);
  $("#known-words-count").html($(".known-word").length);
  $("#new-words-count").html($(".word").length - $(".study-word").length - $(".known-word").length);
}


function toggleStudyKnownWord(){
  var wordId = this.dataset.wordid;
  var wordTranslation = this.dataset.translation;
  var element = this;
  var known = element.classList.contains("known-word");

  if (wordTranslation == "") {
    prompt("please enter translation for " + element.innerHTML);
  }

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
