class MembersController < ApplicationController
  include Sortable

  before_action :show_submenu, only: [:show]

  def index
    @members = @project.members.order("#{sort_column} #{sort_direction}")
  end

  def show
    @member = User.find(params[:id]).decorate
    @sessions = @project.sessions.for_member(@member).order(created_at: :desc).page(params[:page])
  end
end
