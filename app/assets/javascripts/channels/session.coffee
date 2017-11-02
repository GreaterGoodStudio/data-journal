$(document).on "turbolinks:load", ->
  $session = $("#session")

  activeTab = $("[data-active-tab]").data("active-tab")
  $tab = $session.find(".active.tab")
  $count = $session.find(".active.item [data-count]")

  if $session.length
    App.session = App.cable.subscriptions.create {
        channel: "SessionChannel"
        session_id: $session.data('session-id')
      },

      received: (data) ->
        switch data.type
          when "Photo" then @processPhoto(data)
          when "ConsentForm" then @processConsentForm(data)

      processPhoto: (data) ->
        return unless activeTab == "photos"
        $photo = $("[data-photo-id='#{data.id}']")

        if $photo.length
          $photo.replaceWith data.html
          $("[data-tab=data_points]").show()
        else
          $tab.find('form').after data.html

        $count.attr("data-count", $tab.find(".card").length - 1)


      processConsentForm: (data) ->
        return unless activeTab == "consent_forms"
        $tab.find('form').after data.html
        $count.attr("data-count", $tab.find(".card").length - 1)
        $tab.find(".best_in_place").best_in_place()