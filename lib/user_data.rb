require 'csv'

class User_Data
  @@header = []

  def initialize(loginid)
    if File.size?("#{loginid}.csv")
      puts "the file exists"
    else
      puts "the file doesn't exist"
    end
  end
end