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

  # Photo chooser
  $("#choose-photo").click (e) ->
    e.preventDefault()

    initialPhotoId = $("#data_point_croppable_photo_id").val() || $("img[data-photo-id]").data("photo-id")

    PhotoChooser.show initialPhotoId, "Use this photo", (data) ->
      $("#data_point_croppable_photo_id").val data.photoId

      $("form[data-dirty=false]").attr "data-dirty", true

      $img = $("<img src=\"#{data.photoLarge}\" />").attr("id", "croppable").on "load", ->
        $("body").trigger "cropper.init"

      $("#photo-preview").html $img
      $(".ui.modal").modal("hide")

$(document).on "turbolinks:before-visit", ->
  if $("form[data-dirty=true]").length
    confirm("You have not saved your changes yet. Are you sure you want to leave?")
  else
    true