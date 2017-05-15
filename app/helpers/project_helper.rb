module ProjectHelper
  def project_path(project, use_super = false)
    if use_super
      super(project)
    elsif current_user.admin?
      project_members_path(project)
    else
      project_sessions_path(project)
    end
  end
end
