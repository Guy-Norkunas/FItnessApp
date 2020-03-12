require_relative "GuysFitnessApp/version"
require_relative "login"
require_relative "user_data"
require_relative "menu"
require "tty-prompt"

system 'clear'

user = Login.new()

puts "Logged in as #{user.username}"

$user_data = User_Data.new(user.loginid)


while true 
  main_menu()
end