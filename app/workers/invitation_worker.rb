class InvitationWorker
  include Sidekiq::Worker

  def perform(user_id, project_id)
    @member = User.find(user_id)
    @project = Project.find(project_id)

    if @member.invited_to_sign_up?
      @member.deliver_invitation
    else
      ProjectMailer.new_project(@project, @member).deliver
    end
  end
end
