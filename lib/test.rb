require 'tty-table'
require 'tty-prompt'
prompt = TTY::Prompt.new

table = TTY::Table.new  ["header 1", "header 2"], [[1, 2],[3, 4]]
puts table

input = prompt.mask("What is your secret?")
input2 = prompt.mask("What is your secret?")
puts input
puts input2