class SessionChannel < ApplicationCable::Channel
  def subscribed
    session = Session.find params[:session_id]

    if SessionPolicy.new(current_user, session).show?
      stream_for session
    end
  end
end
