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

  def progress
    contributions = get_contribution_count_by_language(language)
    percentage = contributions.to_f / target.to_f * 100
    percentage.ceil.to_s
  end

  def formated_link(formatted_date)
    "http://exercism.io/api/v1/stats/#{username}/#{type}/#{formatted_date}"
  end

  def get_contribution_count_by_language(language)
    a = get_array_by_language(language)
    a.inject(0) {|sum, date| sum + date['count'] }
  end

  def get_array_by_language(language)
    dates = generate_hash.map {|o| o.slice(language).values}
    dates.flatten!
    just_important = dates.select do |d|
      d['date'].to_date.past? && d['date'].to_date >= start_date
    end
    just_important
  end

  def generate_hash
    array = []
    which_links(which_dates).each do |date|
      array << get_body(date)
    end
    array
  end

  def get_body(url)
    response = Faraday.get(url)
    JSON.parse(response.body)
  end

  def start_date
    start_date = Date.today - days_to_pull
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
