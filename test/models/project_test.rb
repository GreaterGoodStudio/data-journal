require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:due_date)

  test "is invalid with bad invitee emails" do
    project = build_stubbed(:project, invitees: ["foo@example"])
    assert_not project.valid?
  end
end
