class ApplicationPolicy
  attr_reader :user, :project, :record

  def initialize(user_context, record)
    @user = user_context.user
    @project = user_context.project
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def new?
    false
  end

  def create?
    new?
  end

  def edit?
    false
  end

  def update?
    edit?
  end

  def destroy?
    update?
  end

  def admin?
    user.admin?
  end

  def moderator?
    admin? || user.moderates?(project)
  end

  def member?
    admin? || project.members.exists?(user.id)
  end

  def owner?
    record.member == user
  end

  class Scope
    attr_reader :user, :project, :scope

    def initialize(user_context, scope)
      @user = user_context.user
      @project = user_context.project
      @scope = scope
    end

    def resolve
      scope
    end

    private

      def admin?
        user.admin?
      end
  end
end
