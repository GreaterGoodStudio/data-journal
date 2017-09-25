$(document).on "turbolinks:load", ->
  # Photo/consent uploaders
  $dimmer = $(".dimmer")
  $loader = $(".loader")

  $("a.upload.card").click (e) ->
    e.preventDefault()
    $(this).next("form").find(".fileupload").trigger("click")

  $(".fileupload").each ->
    uploadPath = $(this).closest("[data-upload-path]").data("upload-path")
    $dropzone = $(this).closest(".segment").find(".upload")

    $(this).fileupload
      dataType: "xml"
      singleFileUploads: !$(this).hasClass("bulk")
      start: ->
        $dimmer.addClass "active"
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $loader.text "Uploading (#{progress}%)"
      done: ->
        $dimmer.removeClass "active"
        $loader.text "Saving"
      error: (xhr, status, error) ->
        $dimmer.removeClass "active"
        alert "Error uploading photo: #{error}"
      success: (data) ->
        return unless data
        $.post uploadPath,
          key: $(data).find("Key").text()

  # Bookmarks
  $("#toggle-bookmarks").click (e) ->
    e.preventDefault()

    $(this).toggleClass("active")

    if $(this).hasClass("active")
      descriptor = "All Data Points"
      $(".icon.remove.bookmark").closest(".ui.card").hide()
    else
      descriptor = "Bookmarks"
      $(".icon.bookmark").closest(".ui.card").show()

    $(this).find("span").text(descriptor)


  $("a .bookmark.icon").click (e) ->
    $(this).toggleClass "remove"

  # Helper to make whole card clickable
  $("#session .ui.card").click (e) ->
    $target = $(e.target)
    link = $target.closest("a")

    if link.length == 0 && !e.isTrigger && !$target.hasClass("best_in_place")
      Turbolinks.visit $(this).find("a:first").attr("href")

  # Photo chooser
  $photoCards = $("#session .ui.card[data-photo-id]")
  $photoCards.click (e) ->
    e.preventDefault()

    initialPhotoId = $(this).data("photo-id")
    sessionSlug = $("#session").data("session-slug")

    PhotoChooser.show initialPhotoId, "New Data Point", (data) ->
      window.location = "/sessions/#{sessionSlug}/data_points/new?photo=#{data.photoId}"