# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.destroy_all
User.where(email: "admin@example.com").first_or_create! do |user|
  user.email = "admin@example.com"
  user.password = "secret"
  user.password_confirmation = "secret"
  user.admin = true
end

User.where(email: "jan@example.com").first_or_create! do |user|
  user.email = "jan@example.com"
  user.password = "secret"
  user.password_confirmation = "secret"
  user.admin = false
end

User.where(email: "martin@example.com").first_or_create! do |user|
  user.email = "martin@example.com"
  user.password = "secret"
  user.password_confirmation = "secret"
  user.admin = false
end

# Boards
Board.destroy_all
Board.where(title: 'Development board').first_or_create! do |board|
  board.title = 'Development board'
  board.creator = User.find_by(email: 'admin@example.com')
end


# Lists
List.destroy_all
list_names = ['Backlog', 'On Hold', 'Current Iteration', 'Done'].freeze
list_names.each do |list_name|
  List.where(title: list_name, creator_id: User.find_by(email: 'admin@example.com').id, board_id: Board.find_by(title: 'Development board').id).first_or_create! do |list|
    list.title = list_name
    list.creator = User.find_by(email: 'admin@example.com')
    list.board = Board.find_by(title: 'Development board')
  end
end


# Cards
Card.destroy_all
(1..20).each do |element|
  card_title = "Task number #{element}"

  Card.where(title: card_title).first_or_create! do |card|
    card.title = card_title
    card.description = card_title
    card.list_id = List.find_by(title: list_names[rand(4)]).id
    card.creator_id = User.find_by(email: 'admin@example.com').id
    user = rand(2) == 0 ? User.where(admin: false).first : User.where(admin: false).last
    card.assignee_id = user.id
  end
end

