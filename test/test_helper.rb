require "simplecov"

SimpleCov.start

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "database_cleaner"

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Devise::Test::IntegrationHelpers

  DatabaseCleaner.strategy = :truncation

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
