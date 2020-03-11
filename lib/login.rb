require 'io/console'
require 'csv'

class Login
  attr_accessor :loginid, :username

  @@loginids = []
  @@usernames = []

  @@csv_users = File.read('users.csv')
  @@csv_users_parsed = CSV.parse(@@csv_users, :headers => true)
  @@csv_users_parsed.each { |line|
    @@usernames << line[0]
    @@loginids << line[1].to_i
  }

  def initialize
    @loginid = start()
    @username = @@usernames[@@loginids.index(@loginid)]
  end

  def start()
    while true
      print "Login or signup?: "
      input = gets.strip

      if input.downcase == "login"
        return self.login()
      elsif input.downcase == "signup"
        return self.signup()
      end

      print "invalid input, type exit to abort: "
      if gets.strip.downcase == "exit"
        exit
      end
    end
  end

  def login()
    while true
      print "username: "
      username = gets.strip
      print "password: "
      password = STDIN.noecho(&:gets).strip
      loginid = self.hash_func(username, password)

      if @@loginids.include?(loginid)
        return loginid
      end

      print "invalid username or password, type exit to abort: "
      if gets.strip.downcase == "exit"
        return self.start
      end
    end
  end

  def signup()
    while true
      print "desired username: "
      username = gets.strip

      if @@usernames.include?(username)
        puts "username already taken, type exit to abort: "
        if gets.strip.downcase == "exit"
          return self.start
        end
        next
      end

      print "password: "
      password1 = STDIN.noecho(&:gets).strip
      print "\nconfirm password: "
      password2 = STDIN.noecho(&:gets).strip

      if password1 == password2
        loginid = self.hash_func(username, password1)
        CSV.open("users.csv", "a") do |csv|
          csv << [username, loginid]
        end

        @@usernames << username
        @@loginids << loginid
        return loginid
      end

      puts "passwords didnt match, type exit to abort"
      if gets.strip.downcase == "exit"
        return self.start
      end
    end
  end

  def hash_func(user, pass)
    hashAddress = 5381
    i = 0
    string = user + pass

    while i < string.length
      hashAddress = ((hashAddress << 5) + hashAddress) + string[i].ord
      i += 1
    end

    return hashAddress
  end
end