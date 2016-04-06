# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Feed.create!(symbol: 'AAPL', name: 'Apple')
Feed.create!(symbol: 'MSFT', name: 'Microsoft')
Feed.create!(symbol: 'GOOG', name: 'Google')
Feed.create!(symbol: 'TWTR', name: 'Twitter')
Feed.create!(symbol: 'FB', name: 'Facebook')

StockInfo.create!(symbol: 'AAPL', name: 'Apple')
StockInfo.create!(symbol: 'MSFT', name: 'Microsoft')
StockInfo.create!(symbol: 'GOOG', name: 'Google')
StockInfo.create!(symbol: 'TWTR', name: 'Twitter')
StockInfo.create!(symbol: 'FB', name: 'Facebook')
