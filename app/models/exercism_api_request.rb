require 'faraday'
require 'json'

class ExercismApiRequest

  attr_reader :days_to_pull, :target, :username, :type, :language
  attr_accessor :user_hash

  def initialize(days_to_pull, target, username, type, language)
    @days_to_pull = days_to_pull
    @target = target
    @username = username
    @user_hash = []
    @type = type
    @language = language
  end



  def self.valid_username?(username)
    Faraday.get("http://exercism.io/api/v1/stats/#{username}/nitpicks/2014/01").status == 200
  end

  def progress
    contributions = get_contribution_count_by_language(language)
    percentage = contributions.to_f / target.to_f * 100
    percentage.ceil.to_s
  end

  def get_count
    contributions = get_contribution_count_by_language(language)
  end

  def formated_link(formatted_date)
    "http://exercism.io/api/v1/stats/#{username}/#{type}s/#{formatted_date}"
  end

  def get_contribution_count_by_language(language)
    a = get_array_by_language(language)
    a.inject(0) {|sum, date| sum + date['count'] }
  end

  def get_all_by_language
    array = []
    languages = ["clojure", "coffeescript", "elixir", "go", "haskell", "javascript", "objective-c", "ocaml", "perl5", "python", "ruby", "scala"]
    languages.each do |l|
     new_array = []
     new_array << l
     new_array << get_contribution_count_by_language(l)
     array << new_array
    end
    array
  end

  def get_array_by_language(language)
    if language != "any language"
      dates = generate_hash.map {|o| o.slice(language).values}
      dates.flatten!
      just_important = dates.select do |d|
        d['date'].to_date.past? && d['date'].to_date >= start_date
      end
      just_important
    else
    mega_array = []
     generate_hash.each do |month|
        month.values.each do |language_array|
          language_array.each do |dates|
            mega_array << dates
          end
        end
      end
      just_important = mega_array.select do |d|
        d['date'].to_date.past? && d['date'].to_date >= start_date
      end
      just_important
    end
  end

  def generate_hash
    array = []
    which_links(which_dates).each do |date|
      array << get_body(date)
    end
    array
  end

  def get_body(url)
    Rails.cache.fetch("exercism_#{username}", expires_in: 5.minutes) do
      response = Faraday.get(url)
      JSON.parse(response.body)
    end
  end

  def start_date
    Date.today - days_to_pull
  end

  def which_dates
    date_range = start_date..Date.today
    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    date_months.map {|d| d.strftime "%Y/%m" }
  end

  def which_links(which_dates)
    urls = []
    which_dates.each do |date|
      urls << formated_link(date)
    end
    urls
  end

end
