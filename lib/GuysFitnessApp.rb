require_relative "GuysFitnessApp/version"
require_relative "login"
require_relative "user_data"
require_relative "menu"
require "tty-prompt"

system 'clear'

if ARGV.length == 0
  user = Login.new()
  puts "Logged in as #{user.username}"
  $user_data = User_Data.new(user.loginid)
else
  case ARGV[0]

  when "set-default"
    puts "set default login"
    user = Login.new()
    File.open("./data/default", "w") do |line|
      line << user.loginid
    end
    puts "#{user.username} has been set as the default user"
    exit

  when "remove-default"
    puts "remove default login"
    File.open("./data/default", "w") do |line|
      line << nil
    end
    exit

  when "default"
    puts "default login"
    if !File.size?("./data/default")
      puts "There was no default user set"
      exit
    end
    File.open("./data/default").each do |line|
      $user_data = User_Data.new(line)
    end

  else
    puts "invalid command line argument"
    exit
  end
end

while true 
  main_menu()
end