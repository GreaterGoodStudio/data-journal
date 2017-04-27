class ProjectsController < ApplicationController
  include ProjectHelper

  before_action :find_project
  before_action :show_submenu, only: [:edit]

  def index
    @projects = policy_scope(Project).order(archived: :asc, created_at: :desc).page params[:page]
  end

  def show
    redirect_to project_path(@project)
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      InviteMembers.call(@project, *@project.invitees)
      redirect_to project_sessions_path(@project), notice: "Project created."
    else
      respond_to do |format|
        format.html { render :new, error: @project.errors.full_messages.to_sentence }
        format.js { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @moderators = @project.memberships.moderators
  end

  def update
    if @project.update_attributes(project_params)
      InviteMembers.call(@project, *@project.invitees)
      redirect_to edit_project_path(@project), notice: "Project updated."
    else
      flash.now[:error] = @project.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
  end

  def archive
    @project.update_attributes archived: true
    redirect_to :back
  end

  def unarchive
    @project.update_attributes archived: false
    redirect_to :back
  end

  private

    def find_project
      return unless params[:id]
      
      @project = Project.friendly.find(params[:id])
      authorize @project
    end

    def project_params
      params.require(:project).permit(:name, :due_date, :archived, invitees: [])
    end
end
