#= require jcrop
#= require_self

class Cropper
  constructor: ($el, selection) ->
    $el.Jcrop
      aspectRatio: 1
      onSelect: @update
      onChange: @update
      setSelect: selection

  update: (coords) =>
    $("[id$=_crop_x]").val(coords.x)
    $("[id$=_crop_y]").val(coords.y)
    $("[id$=_crop_w]").val(coords.w)
    $("[id$=_crop_h]").val(coords.h)

$(document).on "turbolinks:load", ->
  $("#croppable").on "load", ->
    $img = $(this)
    width = $(this).width()
    height = $(this).height()
    offset = Math.abs(width - height) / 2

    selection = if width > height
                  [offset, 0, offset + height, height]
                else
                  [0, offset, width, offset + width]

    new Cropper($img, selection)    