# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_relative 'seeds/books'
require_relative 'seeds/events'
require_relative 'seeds/people'
require_relative 'seeds/screencasts'
require_relative 'seeds/talks'
require_relative 'seeds/tutorials'


BOOKS.map do |b|
  processed = b.reject { |(k)| k === :authorIds }
  Book.create(processed)
end

EVENTS.map do |b|
  processed = b.reject { |(k)| k === :authorIds }
  Event.create(processed)
end

PEOPLE.map do |b|
  processed = b.reject { |(k)| k === :authorIds }
  Person.create(processed)
end

SCREENCAST.map do |b|
  processed = b.reject { |(k)| k === :authorIds }
  Screencast.create(processed)
end

TALKS.map do |b|
  processed = b.reject { |(k)| k === :authorIds || k === :eventId }
  Talk.create(processed)
end

TUTORIALS.map do |b|
  processed = b.reject { |(k)| k === :authorIds }
  Tutorial.create(processed)
end

