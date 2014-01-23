
get "/all" do
  @count = User.all.count
  @users = User.all
  @params = params
  erb :count
end

get "/register/:username"
  #Find the token by params[:token]
  #if exists
  #Look for the username - if exists return current stats
  #else save username - return current stats
end

#apollo code

#require 'net/http'

#my_token = config.github-history-token
#OR my_token = Token.find_by... etc
#url = URI.parse("productionlink/register/#{username}?token=#{token}")
#request = Net::HTTP::Get.new(url.path)
#response = Net::HTTP.start(url.host, url.port) {|http|
#http.request(req)
#}

#response.body stores the json response from the other app

# rails app Apollo contacts this app
# Apollo tells the app the username and the token
# this app checks the token
# checks the username
# creates a new track_user instance in the database (unless one exists)

# post "/register" do
#    @user = User.new(:github_username => params[:github_username])
#    @user.save
#   redirect '/all'
# end


#We want to store the commits from the very first date in the array
#(the day that is about to be lost from github) - combine old array with the github new array
#do calculations on this
#Work in Progress

# get "/register" do
#   erb :register
# end

# #call from the terminal to access
# #curl --data "github_username=rrgayhart" http://localhost:4567/register?token=${GITHUB_CONTRIBUTION_TOKEN}




