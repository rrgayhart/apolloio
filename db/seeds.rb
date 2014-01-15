# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Api.create(:provider => 'Github', image_url: "githublogo.png")
Api.create(:provider => 'Fitbit', image_url: "fitbitlogo.png")
Api.create(:provider => 'Exercism', image_url: "exercismlogo.png")

ApiAccount.create(user_id: 1, api_id: 1, api_username: "Jonah")
ApiAccount.create(user_id: 1, api_id: 2, api_username: "Q")

Goal.create(user_id: 1, target: 5, period: 10, period_type: "weekly", pledge: "I am committing to reach 1 commit every 1 days", api_account_id: 1)

Reminder.create(user_id: 1, goal_id: 1, target: 4, time_deadline: 1400, day_deadline: 4, twitter: true)


