class SessionChannelWorker
  include Sidekiq::Worker

  def perform(session_id, resource_type, resource_id)
    session = Session.find(session_id)
    resource = resource_type.constantize.find(resource_id)

    SessionChannel.broadcast_to(session,
        id: resource_id,
        type: resource_type,
        html: send("render_#{resource_type.underscore}", resource)
      )
  end

  private

    def render_photo(photo)
      SessionsController.render partial: "photos/photo", locals: { photo: photo }
    end

    def render_consent_form(consent_form)
      SessionsController.render partial: "consent_forms/consent_form", locals: { consent_form: consent_form }
    end
end
