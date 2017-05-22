$(document).on "turbolinks:load", ->
  # Photo/consent uploaders
  $dimmer = $(".dimmer")
  $loader = $(".loader")

  $("a.upload.card").click (e) ->
    e.preventDefault()
    $(this).next("form").find(".fileupload").trigger("click")

  $(".fileupload").each ->
    $dropzone = $(this).closest(".segment").find(".upload")

    $(this).fileupload
      dataType: "xml"
      dropZone: $dropzone
      singleFileUploads: !$(this).hasClass("bulk")
      start: ->
        $dimmer.addClass "active"
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $loader.text "Uploading (#{progress}%)"
      done: ->
        $dimmer.removeClass "active"
        $loader.text "Saving"
      success: (data) ->
        return unless data
        $.post "#{location.pathname}/upload/photo",
          key: $(data).find("Key").text()

  # Bookmarks
  $("#toggle-bookmarks").click (e) ->
    e.preventDefault()
    $(this).toggleClass("active")
    descriptor = if $(this).hasClass("active") then "All Data Points" else "Bookmarks"
    $(this).find("span").text(descriptor)

    $(".icon.remove.bookmark").closest(".ui.card").toggle()

  $("a .bookmark.icon").click (e) ->
    $(this).toggleClass "remove"
    
