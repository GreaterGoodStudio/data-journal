$(document).on "turbolinks:load", ->
  $modal = $("#photo-chooser.modal")
  $slick = $modal.find(".slick")

  $btnAction = $modal.find(".action.button")
  $btnClose = $modal.find(".close.button")

  $currentImg = $(".current.image")
  $currentSlide = undefined

  $slideIndex = $("[data-slide-index]")
  $slideTotal = $("[data-slide-total]")

  $prevNext = $modal.find(".chevron.circle.icon")

  selectedIndex = 0
  btnActionCallback = (() -> )

  $modal.modal
    onShow: ->
      $slick.hide()
      $currentImg.attr "src", ""
    onVisible: ->
      unless $slick.hasClass("slick-initialized")
        $slideTotal.text $slick.find("[data-photo-id]").length

        $slick
          .slick
            slidesToScroll: 1
            slidesToShow: 10
            prevArrow: "<i class=\"angle left icon\"></i>"
            nextArrow: "<i class=\"angle right icon\"></i>"
          .on "beforeChange", (e, slick, currentSlide, nextSlide) ->
            $currentSlide = slick.$slides.eq(nextSlide)

            $slideIndex.text nextSlide + 1
            $currentImg.attr "src", $currentSlide.data("photo-square")

      $slick
        .show()
        .slick "slickGoTo", selectedIndex, true

  $slick.on "click", ".slick-slide", ->
    $slick.slick "slickGoTo", $(this).data("slick-index")

  $btnClose.click (e) ->
    e.preventDefault()
    $modal.modal("hide")

  $btnAction.click (e) ->
    e.preventDefault()
    btnActionCallback $currentSlide.data()

  $prevNext.click (e) ->
    e.preventDefault()
    direction = if $(this).hasClass("left") then "slickPrev" else "slickNext"
    $slick.slick direction

  # PhotoChooser
  window.PhotoChooser =
    show: (initialPhotoId, btnLabel, btnCallback) ->
      $photo = $slick.find("[data-photo-id='#{initialPhotoId}']").last()
      selectedIndex = if $slick.hasClass("slick-initialized") then $photo.data("slick-index") else $slick.find("[data-photo-id]").index($photo)
      btnActionCallback = btnCallback

      $slideIndex.text selectedIndex + 1
      $btnAction.text btnLabel

      $modal.modal("show")