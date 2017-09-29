$(document).on "turbolinks:load", ->
  $modal = $("#photo-chooser.modal")
  $slick = $modal.find(".slick")

  $btnAction = $modal.find(".action.button")
  $btnClose = $modal.find(".close.button")
  $btnDownload = $modal.find(".download.button")
  $btnDelete = $modal.find(".delete.button")

  $btnPrevNext = $modal.find(".prevnext .angle.icon")
  $btnPrev = $btnPrevNext.filter(".left")
  $btnNext = $btnPrevNext.filter(".right")

  $currentImg = $(".current.image")
  $currentSlide = undefined

  $slideIndex = $("[data-slide-index]")
  $slideTotal = $("[data-slide-total]")

  initialIndex = 0
  btnActionCallback = (() -> )

  selectSlide = (slideIndex, disableAnimation = false) ->
    $allSlides = $slick.find(".slick-slide")
    $currentSlide = $allSlides.eq(slideIndex)

    return if slideIndex > $allSlides.length - 1

    $allSlides.removeClass("selected")
    $currentSlide.addClass("selected")
    $btnPrev.toggleClass "disabled", slideIndex == 0
    $btnNext.toggleClass "disabled", slideIndex >= $allSlides.length - 1

    $slideIndex.text slideIndex + 1
    $currentImg.attr "src", $currentSlide.data("photo-square")

    photoId = $currentSlide.data("photo-id")
    $btnDelete.attr "href", "/photos/#{photoId}"
    $btnDownload.attr "href", "/photos/#{photoId}/download"

    $slick
      .slick "slickGoTo", slideIndex, disableAnimation
      .show()

  $modal.modal
    onShow: ->
      $slick.hide()
      $btnPrevNext.addClass("disabled")
      $currentImg.attr "src", ""
    onVisible: ->
      # FIX: Delay the carousel loading a little bit
      setTimeout ->
        unless $slick.hasClass("slick-initialized")
          $slideTotal.text $slick.find("[data-photo-id]").length

          $slick
            .slick
              accessibility: false
              # centerMode: true
              # centerPadding: 0
              infinite: false
              slidesToScroll: 3
              slidesToShow: 7
              prevArrow: "<i class=\"angle left icon\"></i>"
              nextArrow: "<i class=\"angle right icon\"></i>"

          $(document).keydown (e) ->
            switch e.which
              when 37 then $btnPrev.trigger "click"
              when 39 then $btnNext.trigger "click"
              when 13 then $btnAction.trigger "click"

        selectSlide(initialIndex, true)
      , 250

  $slick.on "click", ".slick-slide", (e) ->
    e.preventDefault()
    selectSlide $(this).data("slick-index")
 
  $btnClose.click (e) ->
    e.preventDefault()
    $modal.modal("hide")

  $btnAction.click (e) ->
    e.preventDefault()
    btnActionCallback $currentSlide.data()

  $btnPrevNext.click (e) ->
    e.preventDefault()

    direction = if $(this).hasClass("left") then "prev" else "next"
    $nextSlide = $currentSlide[direction](".slick-slide")

    if $nextSlide.length
      selectSlide $nextSlide.data("slick-index")

  # PhotoChooser
  window.PhotoChooser =
    show: (initialPhotoId, btnLabel, btnCallback) ->
      $photo = $slick.find("[data-photo-id='#{initialPhotoId}']").last()
      $btnAction.text btnLabel
      btnActionCallback = btnCallback
      initialIndex = if $slick.hasClass("slick-initialized") then $photo.data("slick-index") else $slick.find("[data-photo-id]").index($photo)

      $modal.modal("show")