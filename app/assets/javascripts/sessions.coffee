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

  # Tabs
  $("[data-tabs] .item").tab
    onLoad: (tabPath, parameterArray, historyEvent) ->
      $("#toggle-bookmarks").toggle tabPath == "data_points"

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
    
