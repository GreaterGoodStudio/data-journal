$(document).on "turbolinks:load", ->
  $('.ui.checkbox .field_with_errors input').unwrap();