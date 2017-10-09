$(document).on "turbolinks:load", ->
  # Carousel

  if $("[data-points-all]").length
    ids = $("[data-points-all]").data("points-all")
    $related = $("#related .card")
    $current = $related.filter(".current")
    $navs = $("#data_point #prev, #data_point #next")
    $navPrev = $navs.filter("#prev")
    $navNext = $navs.filter("#next")
    $dimmer = $("#data_point .dimmer")

    currentIndex = ids.indexOf $current.data("point-id")
    
    $navPrev.toggle currentIndex > 0
    $navNext.toggle currentIndex < ids.length - 1

    $navs.on "click", (e) ->
      e.preventDefault()

      isNext = $(this).is $navNext

      currentIndex = if isNext then Math.min(currentIndex + 1, ids.length - 1) else Math.max(0, currentIndex - 1)
      currentId = ids[currentIndex]

      $navPrev.toggle currentIndex > 0
      $navNext.toggle currentIndex < ids.length - 1

      $next = $related.filter("[data-point-id=#{currentId}]")

      if $next.length
        $current.removeClass "current"
        $current = $next.addClass "current"
        $dimmer.addClass "active"

        href = $current.find("a").attr("href")
        history.pushState null, null, href
        $.get href, (response) ->
          $response = $(response)
          $("#data-point-content").html $response.find("#data-point-content").html()
          $("#data-point-actions").html $response.find("#data-point-actions").html()
          $dimmer.removeClass "active"
      else
        window.location = currentId

    $(document)
      .off "keyup.datapoint"
      .on "keyup.datapoint", (e) ->
        switch e.keyCode
          when 37 # left
            $navPrev.filter(":visible").trigger "click"
          when 39 # right
            $navNext.filter(":visible").trigger "click"

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