require 'csv'

class User_Data
  attr_reader :data

  @@header = ["heading 1", "heading 2", "heading 3"]

  def initialize(loginid)
    @data = start(loginid)
  end
  
  def start(loginid)
    if File.size?("#{loginid}.csv")
      return self.read_file("#{loginid}.csv")
    else
      return self.create_file("#{loginid}.csv")
    end
  end

  def read_file(filename)
    data = []
    csv_data = File.read(filename)
    csv_data_parsed = CSV.parse(csv_data, :headers => true)
    csv_data_parsed.each { |line|
      data << {heading1: line["heading 1"], 
              heading2: line["heading 2"],
              heading3: line["heading 3"]}
    }
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