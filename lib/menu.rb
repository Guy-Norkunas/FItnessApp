require 'tty-prompt'
require 'colorize'

$prompt = TTY::Prompt.new

def main_menu()
  while true
    input = $prompt.select("What would you like to do?".colorize(:blue)) do |menu|
      menu.choice name: "View exercises".colorize(:light_blue),  value: 1
      menu.choice name: "Record new exercise".colorize(:light_blue), value: 2
      menu.choice name: "Remove an exercise".colorize(:light_blue),  value: 3
      menu.choice name: "Exit program".colorize(:light_blue), value: "exit"
    end

    case input
    when 1
      system 'clear'
      $user_data.display()
    when 2
      system 'clear'
      $user_data.record
    when 3
      system 'clear'
      $user_data.delete
    when "exit"
      system 'clear'
      puts "Thanks for using my program"
      exit
    else
    system 'clear'
    puts "invalid input"
    end
  end
end