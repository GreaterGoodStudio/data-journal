class MembershipController < ApplicationController
  before_action :find_membership

  def destroy
    if @membership.destroy
      flash[:notice] = "Member was removed from the project."
    else
      flash[:error] = "Problem removing member from the project."
    end

    redirect_to edit_project_path(@membership.project)
  end

  def promote
    if @membership.update_attributes(moderator: true)
      flash[:notice] = "Member was promoted to moderator."
    else
      flash[:error] = "Problem promoting member to moderator."
    end

    redirect_to edit_project_path(@membership.project)
  end

  def demote
    if @membership.update_attributes(moderator: false)
      flash[:notice] = "Member was demoted."
    else
      flash[:error] = "Problem demoting member."
    end

    redirect_to edit_project_path(@membership.project)
  end

  def reinvite
    if InvitationWorker.perform_async(@membership.user_id, @membership.project_id)
      flash[:notice] = "Invitation was resent."
    else
      flash[:error] = "Problem resending invitation."
    end

    redirect_to edit_project_path(@membership.project)
  end

  private

    def find_membership
      @membership = ProjectMembership.find(params[:id])
    end
end
