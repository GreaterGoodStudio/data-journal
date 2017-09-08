require "test_helper"

class SessionTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:date)
end
