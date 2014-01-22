require 'faraday'
require 'json'

class DuolingoApiRequest

attr_reader :username, :response, :language

def initialize(username, language)
  @username = username
  @response = call
  @language = language
end

def self.valid_username?(username)
  Faraday.get("http://www.duolingo.com/users/#{username}").status == 200
end

def call
  Rails.cache.fetch("duolingo_#{username}", expires_in: 5.minutes) do
    response = Faraday.get("http://www.duolingo.com/users/#{username}")
    JSON.parse(response.body)
  end
end

def get_site_streak
  response["site_streak"]
end

def get_details_by_language
  languages = response['languages']
  languages.select{ |lang| lang['language_string'] == language.capitalize }
  #this gets streak, language string, level, points, learning (boolean), current_learning (boolean), sentences_translated
end

def get_streak
  if language == "Any Language"
    get_site_streak
  else
    get_details_by_language[0]["streak"]
  end
end

def progress
  if get_streak > 0
    "100"
  else
    "0"
  end
end

def get_count
  if get_streak > 0
    1
  else
    0
  end
end


end
