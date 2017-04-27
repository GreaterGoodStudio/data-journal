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
        $.post "#{location.pathname}/upload/photo",
          key: $(data).find("Key").text()

  # Bookmarks
  $("#toggle-member-bookmarks").click (e) ->
    e.preventDefault()
    $("[data-bookmark-member='false']").toggle()

  $("#toggle-moderator-bookmarks").click (e) ->
    e.preventDefault()
    $("[data-bookmark-moderator='false']").toggle()
