# This is a manifest file that"ll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin"s vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It"s not advisable to add code directly here, but if you do, it"ll appear at the bottom of the
# compiled file. JavaScript code in this file should be added after the last require_* statement.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery-fileupload/basic
#= require semantic_ui/semantic_ui
#= require semantic-ui-calendar
#= require best_in_place
#= require turbolinks
#= require_tree .
#= require_self

$(document).on "turbolinks:load", ->
  # In-place editing
  $(".best_in_place").best_in_place()

  # Closable message
  $(".message.closable .close.icon").on "click", ->
    $(".message.closable").fadeOut("slow")
    false
  setTimeout ->
    $(".message.closable").fadeTo "slow", 0, ->
      $(this).slideUp()
  , 3000

  # Dropdown menus
  $(".ui.dropdown:not(.allow-addition)").dropdown()
  $(".ui.dropdown.allow-addition").dropdown
    selectOnKeydown: false
    forceSelection: false
    fullTextSearch: true
    allowAdditions: true
    hideAdditions: false

  # Tabs
  $("[data-tabs] .item").tab()

  # Checkboxes
  $(".ui.checkbox").checkbox()

  # Calendar
  $(".ui.calendar").calendar
    type: "date"

  # Project summary
  $("[data-project-summary]").popup
    on: "hover"
    title: "Project Summary"
    onShow: (el) ->
      sessionCount = $(el).data("sessions")
      dataPointCount = $(el).data("data-points")
      popup = this
      popup.html """
        <div class="small header">
          Sessions Completed
          <div class="large sub header normal grey text">#{sessionCount}</div>
        </div><br>

        <div class="small header">
          Data Points Completed
          <div class="large sub header normal grey text">#{dataPointCount}</div>
        </div>
      """


  # Slide open content
  $("[data-transition]").click ->
    target = $(this).data("target")
    transition = $(this).data("transition")
    $(target)[transition]("fast")
    # return false?
    $(this).attr("href") != "#"

  # Form errors
  $("form")
    .on "submit", (e, xhr) ->
      message = $(this).data("loading-text")
      if message
        $loading = $("#loading-overlay")
        $loading
          .find(".loader").text(message).end()
          .addClass "active"
    .on "ajax:error", (e, xhr) ->
      $form = $(this)
      response = JSON.parse(xhr.responseText)
      $("#loading-overlay").removeClass "active"
      $form
        .find(".field").removeClass("error")
        .find(".helper").remove()
      for field, errors of response
        return unless errors.length

        $el = $(this).find("[name*='[#{field}]']")
        $el.closest(".field")
          .addClass("error")
          .append("<small class='helper'>#{errors.join(', ')}.</small>")
