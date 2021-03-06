require "test_helper"

class ProjectPolicyTest < ActiveSupport::TestCase
  def setup
    @project = create(:project)
  end

  test "member permissions"  do
    member = @project.members.first
    non_member = build_stubbed(:user, name: "Non-Team Member")

    assert_not ProjectPolicy.new(UserContext.new(member, nil), Project.new).new?
    assert_not ProjectPolicy.new(UserContext.new(non_member, @project), @project).show?
    # assert     ProjectPolicy.new(member, @project).show?
  end

  test "moderator permissions" do
    moderator = create(:moderator_user)
    @project.memberships << create(:project_membership, member: moderator, moderator: true)

    assert_not ProjectPolicy.new(UserContext.new(moderator, nil), Project.new).new?
    # assert     ProjectPolicy.new(moderator, @project).show?
  end

  test "admin permissions" do
    admin = build_stubbed(:admin_user)

    assert ProjectPolicy.new(UserContext.new(admin, nil), Project.new).new?
    assert ProjectPolicy.new(UserContext.new(admin, @project), @project).show?
  end
end
