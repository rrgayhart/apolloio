# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Apolloio::Application.initialize!

# Test mock for omniauth
OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      "uid" => "1234567890",
      "provider" => "twitter",
      "info" => {
      "name" => "appolo"
    }
})
