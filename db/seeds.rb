# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
user = User.create()

github = Api.create(:provider => 'Github', image_url: "githublogo.png")
fitbit = Api.create(:provider => 'Fitbit', image_url: "fitbitlogo.png")
exercism = Api.create(:provider => 'Exercism', image_url: "exercismlogo.png")

mhartl = ApiAccount.create(user_id: user.id, api_id: github.id, api_username: "mhartl")
ApiAccount.create(user_id: user.id, api_id: fitbit.id, api_username: "Q")

goal = Goal.create(user_id: user.id, target: 5, period_type: "weeks", pledge: "I am committing to reach 1 commit every 1 days", api_account_id: mhartl.id)

Reminder.create(user_id: user.id, goal_id: goal.id, target: 4, time_deadline: "evening", day_deadline: 'Monday', twitter: true)
