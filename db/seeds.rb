# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

10.times do |i|
User.create(
    email: "user#{i+1}@example.com",
    first_name: "FirstName#{i+1}",
    last_name: "LastName#{i+1}"
)
end

10.times do |i|
Chat.create(
    sender_id: i+1,
    receiver_id: (i+2)%10+1
)
end


10.times do |i|
Message.create(
    chat_id: i+1,
    user_id: (i+1)%10+1,
    body: "Este es el mensaje número #{i+1}."
)
end