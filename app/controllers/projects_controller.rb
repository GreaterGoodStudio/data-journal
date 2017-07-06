class ProjectsController < ApplicationController
  include Sortable

  before_action :find_project
  before_action :show_submenu, only: [:edit]

  def index
    @projects = policy_scope(Project).order("archived ASC, #{sort_column} #{sort_direction}").page params[:page]
    authorize :project
  end

  def show
    respond_to do |format|
      format.pdf do
        @data_points = @project.data_points.order(:session_id)
        render pdf: @project.slug
      end
      format.html { redirect_to project_sessions_path(@project) }
    end
  end

  def members
    @members = @project.members.decorate
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      InviteMembers.call(@project, *@project.invitees)
      respond_to do |format|
        format.js
        format.html { redirect_to project_sessions_path(@project), notice: "Project created." }
      end
    else
      respond_to do |format|
        format.js { render json: @project.errors, status: :unprocessable_entity }
        format.html { render :new, error: @project.errors.full_messages.to_sentence }
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
      return unless params[:id].present?

      @project = Project.friendly.find(params[:id])
      authorize @project
    end

    def project_params
      params.require(:project).permit(:name, :due_date, :archived, invitees: [])
    end
end
