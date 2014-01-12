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
