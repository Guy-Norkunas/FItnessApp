require_relative "GuysFitnessApp/version"
require_relative "login"
require 'csv'


user = Login.new()

p user.loginid
p user.username

system 'clear'

temp = []

csv_text = File.read('test.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each { |stuff|
 temp << stuff
}

pp temp

def options()
  puts "type 1 to view content"
  puts "type 2 to edit content"
  puts "type 3 to remove content"
  puts "anything else and the program will exit"
end

def view_content()
  temp.each{


  }
end

def add_content()
  puts "add options"
end

def remove_content()  
  puts "remove options"
end

def exit_program()
  puts "exit program"
end

while true
  options()
  case gets.strip
  when "1"
    view_content()
  when "2"
    add_content()
  when "3"
    remove_content()
  else
    exit_program()
  end
end