class ExercismChart

  def format_month
    date = Date.today
    date.strftime("%Y/%m")
  end

  def formated_link(username, type)
    "http://exercism.io/api/v1/stats/#{username}/#{type}s/#{format_month}"
  end

  def get_body(username, type)
      response = Faraday.get(formated_link(username, type))
      JSON.parse(response.body)
  end

  def submissions(username)
    get_body(username, 'submission')
  end

  def nitpicks(username)
    get_body(username, 'nitpick')
  end

  def generate_chart_subs(username)
    subs = submissions(username)
    sub_array = subs.map do |language|
      array_of_commits(language[1])
    end
    chart_maker(sub_array, username, 'Submissions this Month')
  end

  def generate_chart_nits(username)
    nits = nitpicks(username)
    nit_array = nits.map do |language|
      array_of_commits(language[1])
    end
    chart_maker(nit_array, username, 'Nitpicks this Month')
  end

  def chart_maker(chart_array, username, title)
    Gchart.line(
          :title => title,
          :data => chart_array, 
          :bar_colors => ['7ff58e',   '6d5da3',
'25b28e',   '5b50d3',
'd028de',   'e97ad7',
'c7bf0a',   'dd3d4c',
'9e7d53',   'b66e74',
'f3322a', 'eba138'],
          :stacked => false, :size => '875x300',
          :legend => nitpicks(username).keys,
          :max_value => chart_array.flatten.max + 1,
          :axis_labels => [(1..Date.today.end_of_month.mday).to_a,['',(chart_array.flatten.max) / 2, chart_array.flatten.max]],
          :axis_with_labels => "x,y")
  end

  def array_of_commits(language)
    language.map { |pair| pair['count']} 
  end
end
