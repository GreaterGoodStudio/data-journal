$(document).on "turbolinks:load", ->
  $session = $("#session")

  $photos = $session.find(".tab[data-tab='photos']")
  $photoCount = $session.find("[data-tab='photos'] [data-count]")
  $consentForms = $session.find(".tab[data-tab='consent_forms']")
  $consentFormCount = $session.find("[data-tab='consent_forms'] [data-count]")

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
        $photo = $("[data-photo-id='#{data.id}']")

        if $photo.length
          $photo.replaceWith data.html
        else
          $photos.find('form').after data.html

        $photoCount.attr("data-count", $photos.find(".card").length - 1)


      processConsentForm: (data) ->
        $consentForms.find('form').after data.html
        $consentFormCount.attr("data-count", $consentForms.find(".card").length - 1)