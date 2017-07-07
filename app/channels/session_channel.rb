class SessionChannel < ApplicationCable::Channel
  def subscribed
    session = Session.find params[:session_id]

    if SessionPolicy.new(UserContext.new(current_user, session.project), session).show?
      stream_for session
    end
  end
end
