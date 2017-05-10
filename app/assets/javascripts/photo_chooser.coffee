$(document).on "turbolinks:load", ->
  # Listen for iframe messages
  window.addEventListener "message",  (e) ->
    return unless e.origin == location.origin

    name = e.data.name
    data = e.data.data
    $modal = $(".ui.modal")

    switch name
      when "photo.selected"
        $("#data_point_croppable_photo_id").val(data.id)

        $img = $(data.img).attr("id", "croppable").on "load", ->
          $("body").trigger "cropper.init"

        $("#photo-preview").html $img
        $modal.modal("hide")

  # Listen for a photo chosen inside the iframe
  $("body#modal [data-photo-id]").on "click", (e) ->
    e.preventDefault()

    img = $(this).find("img").clone()
    img.attr "src", $(this).data("photo-large")

    parent.postMessage
      name: "photo.selected"
      data:
        id: $(this).data("photo-id")
        img: img.prop("outerHTML")
    , location.origin

  # Show the modal
  $("#photo-chooser").on "click", (e) ->
    e.preventDefault()

    $modal = $(".ui.modal")
    $dimmer = $modal.find(".dimmer").addClass("active")
    $embed = $modal.find(".ui.embed")

    $modal.modal
        closable: true
        onShow: ->
          $embed.embed
            onDisplay: ->
              setTimeout ->
                $dimmer.removeClass "active"
              , 1000
      .modal("show")