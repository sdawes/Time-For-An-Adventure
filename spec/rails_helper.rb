ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'web_helper'
require 'rspec/rails'
require 'capybara/rails'


ActiveRecord::Migration.maintain_test_schema!

module AuthHelpers

end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.include Warden::Test::Helpers

  config.before :suite do
    Warden.test_mode!
  end

  config.include AuthHelpers, type: :feature

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryGirl::Syntax::Methods


  config.include Warden::Test::Helpers
    config.before :suite do
      Warden.test_mode!
    end
    config.after :each do
      Warden.test_reset!
    end
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    with.library :rails
  end
end
