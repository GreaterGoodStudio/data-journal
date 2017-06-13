$(document).on "turbolinks:load", ->
  $("textarea[maxlength]").each ->
    $textarea = $(this)
    $counter = $textarea.next("small").find("span")
    $counter.text $textarea.val().length

    $textarea.on "keyup", ->
      numChars = $textarea.val().length
      $counter.text numChars

  $("#data_point .ui.sticky").sticky
    context: "#data_point"
    offset: 70

  $("form[data-dirty=false]").on "keyup", ->
    $(this).attr "data-dirty", true

$(document).on "turbolinks:before-visit", ->
  if $("form[data-dirty=true]").length
    confirm("You have not saved your changes yet. Are you sure you want to leave?")
  else
    true