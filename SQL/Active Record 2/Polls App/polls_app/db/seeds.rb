# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{username: 'João'}, {username: 'Pedro'}, {username: 'Clara'}])
Poll.create([{title: 'Age Poll', author_id: 1}])
Question.create([{text: 'How old are you?', poll_id: 1}])
Question.create([{text: 'Do you feel old??', poll_id: 1}])
AnswerChoice.create([{text: '10-20', question_id: 1}, {text: '20-30', question_id: 1},{text: '30-40', question_id: 1}, {text: 'Yes', question_id: 2}, {text: 'No', question_id: 2}])
Response.create([{answer_id: 1, user_id: 2}, {answer_id: 2, user_id: 3}, {answer_id: 5, user_id: 3}, {answer_id: 4, user_id: 2}])