ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "database_cleaner"
require "capybara/rails"
require 'capybara-webkit'
require 'timecop'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/emoji"
# require 'minitest/reporters'
# MiniTest::Reporters.use!
require "minitest/pride"
require 'faraday'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = './cassettes'
  c.hook_into :faraday
end

def limited_setup
  @auth = OmniAuth.config.mock_auth[:twitter]
  @user = User.from_omniauth(@auth)

  api1  = FactoryGirl.create(:api, :github)
  api2  = FactoryGirl.create(:api, :exercism)
  api3  = FactoryGirl.create(:api, :fitbit)
  @apis = [api1, api2, api3]

  @api_account1 = FactoryGirl.create(:api_account, api: api1, user: @user, api_username: "mhartl")
  @api_account2 = FactoryGirl.create(:api_account, api: api2, user: @user, api_username: "kytrinyx")
  @api_account3 = FactoryGirl.create(:api_account, api: api3, user: @user)
  @api_accounts = [@api_account1, @api_account2, @api_account3]
end

def capybara_setup
  @auth = OmniAuth.config.mock_auth[:twitter]
  @user = User.from_omniauth(@auth)
  other_user = FactoryGirl.create(:user)

  api1  = FactoryGirl.create(:api, :github)
  api2  = FactoryGirl.create(:api, :exercism)
  api3  = FactoryGirl.create(:api, :fitbit)
  @apis = [api1, api2, api3]

  @api_account1 = FactoryGirl.create(:api_account, api: api1, user: @user, api_username: "mhartl")
  @api_account2 = FactoryGirl.create(:api_account, api: api2, user: @user, api_username: "kytrinyx")
  @api_account3 = FactoryGirl.create(:api_account, api: api3, user: @user)
  @api_accounts = [@api_account1, @api_account2, @api_account3]
  @api_account4 = FactoryGirl.create(:api_account, api: api1, user: other_user, api_username: "jcasimir")

  @goal1 = FactoryGirl.create(:goal, user: @user, api_account: @api_account1, pledge: "one pledge")
  @goal2 = FactoryGirl.create(:goal, user: @user, api_account: @api_account2, pledge: "two pledge")
  @goal3 = FactoryGirl.create(:goal, user: @user, api_account: @api_account3, pledge: "three pledge")
  @goals = [@goal1, @goal2, @goal3]
  @goal4 = FactoryGirl.create(:goal, user: other_user, api_account: @api_account3, pledge: "Other user's goal pledge")

  reminder1  = FactoryGirl.create(:reminder, user: @user, goal: @goal1, target: 403)
  reminder2  = FactoryGirl.create(:reminder, user: @user, goal: @goal1, target: 7852)
  reminder3  = FactoryGirl.create(:reminder, user: @user, goal: @goal1, target: 1986)
  @reminder4 =  FactoryGirl.create(:reminder, user: other_user, goal: @goal1, target: 55)
  @reminders = [reminder1, reminder2, reminder3]
end

class ActiveSupport::TestCase
  self.use_transactional_fixtures = false
  include Capybara::DSL
  include Capybara::Assertions

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all
  DatabaseCleaner.strategy = :truncation

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
