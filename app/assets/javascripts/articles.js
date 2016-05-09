
function updateCounters() {
  var study_words = $(".study-word").map(function(index, element){
    // console.log(element.innerHTML)
    return element.innerHTML.toLowerCase();
  });
  // console.log(study_words)
  study_words = jQuery.unique( study_words );


  var known_words = $(".known-word").map(function(index, element){
    return element.innerHTML.toLowerCase();
  });
  known_words = jQuery.unique( known_words );

  $("#study-words-count").html(study_words.length);
  $("#known-words-count").html(known_words.length);
  $("#new-words-count").html($(".word").length - $(".study-word").length - $(".known-word").length);
}

function createStudyWord(){
  var element = this;
  var wordTranslation = prompt("please enter translation for " + element.innerHTML);
  console.log(wordTranslation);
  var newStudyWord = { name: element.innerHTML.toLowerCase(), translation: wordTranslation, known: false }
  console.log(newStudyWord);
  $.ajax({
    type: "POST",
    complete: function(result) {
      if ( result.statusText === 'OK' ) {
        removeWordListeners()
        console.log(result.responseJSON.word)
        var wordId = result.responseJSON.word.id;
        $(element)
          .addClass("study-word")
          .removeClass("new-word")
          .attr("data-wordid", wordId)
          .attr("data-translation", wordTranslation);
        addWordListeners();
        $(element).next('.translation').text(wordTranslation)
      }
      updateCounters();
    },
    url: "/words.json",
    data: JSON.stringify({ word: newStudyWord }),
    contentType: "application/json",
    dataType: "json"
  });
}


function toggleStudyKnownWord(){
  $('.translation').hide();
  var wordId = this.dataset.wordid;
  var wordTranslation = this.dataset.translation;
  var element = this;
  var known = element.classList.contains("known-word");
  console.log("toggled:", wordId)

  var wordTranslation = prompt("please enter translation for " + element.innerHTML);
  if (wordTranslation === "" || wordTranslation === null) {
    wordTranslation = prompt("you didn't entered any translation.\n please enter translation for " + element.innerHTML);
  }

  $.ajax({
    type: "PATCH",
    complete: function(result) {
      if ( result.responseText === 'success' ) {
        removeWordListeners()
        $('[data-wordid=' + wordId + ']')
          .toggleClass("study-word")
          .toggleClass("known-word");
        addWordListeners();
      }
      updateCounters();
    },
    url: "/words/"+ wordId,
    data: JSON.stringify({ known: !known, translation: wordTranslation }),
    contentType: "application/json",
    dataType: "json"
  });
};

function mouseEnterWord(){
    $(this).next('.translation').show();
}

function mouseLeaveWord()  {
  $(this).next('.translation').hide();
}

function addWordListeners(){
  $('.study-word').on({
    mouseenter: mouseEnterWord,
    mouseleave: mouseLeaveWord,
    click: toggleStudyKnownWord
  });

  $(".known-word").on("click", toggleStudyKnownWord);
  $(".new-word").on("click", createStudyWord);
}


function removeWordListeners(){
  $('.study-word').off({
    mouseenter: mouseEnterWord,
    mouseleave: mouseLeaveWord,
    click: toggleStudyKnownWord
  });

  $(".known-word").off("click", toggleStudyKnownWord);
  $(".new-word").off("click", createStudyWord);
}

$(document).ready(function() {
  $('.translation').hide();
  addWordListeners();
  updateCounters();
});
