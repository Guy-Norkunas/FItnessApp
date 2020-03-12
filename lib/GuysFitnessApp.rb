require_relative "GuysFitnessApp/version"
require_relative "login"
require_relative "user_data"
require_relative "menu"
require "tty-prompt"
require "colorize"

system 'clear'

if ARGV.length == 0
  user = Login.new()
  puts "Logged in as " + "#{user.username}".colorize(:red)
  $user_data = User_Data.new(user.loginid)
else
  case ARGV[0]

  when "set-default"
    puts "set default login"
    user = Login.new()
    File.open("./data/default", "w") do |line|
      line << user.loginid
    end
    puts "#{user.username}".colorize(:red) + " has been set as the default user"
    exit

  when "remove-default"
    puts "remove default login".colorize(:red)
    File.open("./data/default", "w") do |line|
      line << nil
    end
    exit

  when "default"
    puts "default login"
    if !File.size?("./data/default")
      puts "There was no default user set".colorize(:green)
      exit
    end
    File.open("./data/default").each do |line|
      $user_data = User_Data.new(line)
    end
    puts "Logged in as " + "default user".colorize(:red)

  else
    puts "invalid command line argument".colorize(:green)
    exit
  end
end

while true 
  main_menu()
end