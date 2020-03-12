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
    temp = []
    temp2 = []
    print "what exercise would you like to see the contents of?: "
    input = gets.strip.downcase

    @data.each { |hash|
      temp = []
      if hash[:exercise] == input
        hash.each{ |k,v|
          temp << v
        }
        temp2 << temp
      end
    }

    if temp2.length == 0
      puts "invalid input, type exit to abort: "
      if gets.strip.downcase == "exit"
        return false
      end
      return self.display()
    end
    return temp2
  end

  def record()
    print "The date in dd/mm/yyyy format: "
    date = gets.strip
    print "Name of the exercise: "
    exercise = gets.strip.downcase
    print "What was your working weight?: "
    weight = gets.strip
    print "How many reps per set? in set1,set2,set3 format: "
    sets = gets.strip

    CSV.open("./data/#{@loginid}.csv", "a+") do |csv|
      csv << [date, exercise, weight, sets]
    end
    @data = get_data(@loginid)
  end

  def delete()
    pp temp = self.display()
    print "Enter a date you would like to delete: "
    input = gets.strip
    
    temp.each { |exercise|
      if exercise[0] == input
        p exercise
        table = CSV.table("./data/#{@loginid}.csv")
        table.delete_if do |row|  
          (row.to_hash[:date] == exercise[0]) && (row.to_hash[:exercise] == exercise[1])
        end

        File.open("./data/#{@loginid}.csv", 'w') do |f|
          f.write(table.to_csv)
        end
      end
    }
    @data = get_data(@loginid)
  end
end