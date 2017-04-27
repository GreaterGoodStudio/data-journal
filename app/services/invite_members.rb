class InviteMembers

  def self.call(project, *emails)
    emails.each do |email|
      email.downcase!
      member = User.find_by(email: email) || User.invite!(email: email, skip_invitation: true)
      project.memberships.where(member: member).first_or_create do |membership|
        InvitationWorker.perform_async membership.member.id, project.id
      end
    end
  end
end
