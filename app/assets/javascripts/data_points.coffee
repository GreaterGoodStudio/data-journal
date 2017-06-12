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
