require 'csv'

class User_Data
  @@header = ["heading 1", "heading 2", "heading 3"]

  def initialize(loginid)
    @data = start(loginid)
  end
  
  def start(loginid)
    if File.size?("#{loginid}.csv")
      puts "the file exists"
      return self.read_file("#{loginid}.csv")
    else
      puts "the file doesn't exist"
      return self.create_file("#{loginid}.csv")
    end
  end

  def read_file(filename)
    data = []
    puts "got here"
    csv_data = File.read(filename)
    csv_data_parsed = CSV.parse(csv_data, :headers => true)
    csv_data_parsed.each { |line|
      data << {heading1: line[0], 
              heading2: line[1],
              heading3: line[2]}
    }
    pp data
    return data
  end

  def create_file(filename)
    CSV.open(filename, "wb") do |csv|
      csv << @@header
    end
    return self.read_file(filename)
  end

end

temp = User_Data.new(272130433008143434957)