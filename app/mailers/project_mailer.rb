class ProjectMailer < ApplicationMailer
  def new_project(project, member)
    @project = project
    @member = member
    mail(to: @member.email, subject: "[Data Journal] You've been added to \"#{@project.name}\"")
  end
end