require 'csv'

class User_Data
  attr_reader :data

  @@header = ["date", "exercise", "weight", "sets"]

  def initialize(loginid)
    @data = get_data(loginid)
    @loginid = loginid
  end
  
  def get_data(loginid)
    if File.size?("./data/#{loginid}.csv")
      return self.read_file("./data/#{loginid}.csv")
    else
      return self.create_file("./data/#{loginid}.csv")
    end
  end

  def read_file(filename)
    data = []
    csv_data = File.read(filename)
    csv_data_parsed = CSV.parse(csv_data, :headers => true)
    csv_data_parsed.each { |line|

      data << {date: line[0], 
              exercise: line[1],
              weight: line[2],
              sets: line[3]}
    }
    return data
  end

  def create_file(filename)
    CSV.open(filename, "wb") do |csv|
      csv << @@header
    end
    return self.read_file(filename)
  end

  def display()
    unique = []
    counter = 1
    found = false

    @data.each { |hash|
      if !unique.include?(hash[:exercise])
        print "option #{counter}: #{hash[:exercise]}\n".colorize(:light_blue)
        unique << hash[:exercise]
        counter += 1
      end

    }

    print "\nwhat exercise would you like to see the contents of?: ".colorize(:blue)
    input = $stdin.gets.strip.downcase
    puts "Data for #{input}".colorize(:light_blue)
    @data.each { |hash|
      if hash[:exercise] == input
        puts "Date: #{hash[:date]}, Weight: #{hash[:weight]}, Sets: [#{hash[:sets]}]".colorize(:yellow)
        found = true
      end
    }

    if !found
      input = $prompt.select("Invalid exercise".colorize(:blue)) do |menu|
        menu.choice name: "Continue".colorize(:light_blue),  value: "anything"
        menu.choice name: "Abort".colorize(:red), value: "exit"
      end
      if input == "exit"
        return false
      end
      return self.display()
    end
    
    return input
  end

  def record()
    print "The date in dd/mm/yyyy format: ".colorize(:light_blue)
    date = $stdin.gets.strip
    print "Name of the exercise: ".colorize(:light_blue)
    exercise = $stdin.gets.strip.downcase
    print "What was your working weight?: ".colorize(:light_blue)
    weight = $stdin.gets.strip
    print "How many reps per set? in set1,set2,set3 format: ".colorize(:light_blue)
    sets = $stdin.gets.strip

    CSV.open("./data/#{@loginid}.csv", "a+") do |csv|
      csv << [date, exercise, weight, sets]
    end
    @data = get_data(@loginid)
  end

  def delete()
    found = false

    exercise = self.display()

    if !exercise
      return false
    end

    print "Enter a date you would like to delete: ".colorize(:blue)
    date = $stdin.gets.strip
    
    @data.each { |hash|
      if (hash[:exercise] == exercise) && (hash[:date] == date)
        found = true
        table = CSV.table("./data/#{@loginid}.csv")
        table.delete_if do |row|
          (row.to_hash[:date] == hash[:date]) && (row.to_hash[:exercise] == hash[:exercise])
        end

        File.open("./data/#{@loginid}.csv", 'w') do |f|
          f.write(table.to_csv)
        end
      end
    }
    @data = get_data(@loginid)

    if !found
    input = $prompt.select("Invalid date".colorize(:blue)) do |menu|
        menu.choice name: "Continue".colorize(:light_blue),  value: "anything"
        menu.choice name: "Abort".colorize(:red), value: "exit"
      end
      if input == "exit"
        return false
      end
      return self.delete
    end
  end
end