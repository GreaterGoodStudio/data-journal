require "test_helper"

class ProjectPolicyTest < ActiveSupport::TestCase
  test "member permissions"  do
    member = build(:user)
    assert_not ProjectPolicy.new(member, Project.new).new?
  end
end
