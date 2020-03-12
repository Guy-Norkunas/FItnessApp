require 'csv'
require 'tty-prompt'

class Login
  attr_reader :loginid, :username

  @@usernames = []
  @@loginids = []

  @@csv_users = File.read('./data/users.csv')
  @@csv_users_parsed = CSV.parse(@@csv_users, :headers => true)
  @@csv_users_parsed.each { |line|
    @@usernames << line[0]
    @@loginids << line[1].to_i
  }

  def initialize
    @loginid = start()
    @username = @@usernames[@@loginids.index(@loginid)]
    @slackid = slack_setup()
  end

  def start()
    while true
      input = $prompt.select("What would you like to do?".colorize(:blue)) do |menu|
      menu.choice name: "Log in".colorize(:light_blue),  value: "login"
      menu.choice name: "Sign up".colorize(:light_blue), value: "signup"
      menu.choice name: "Exit".colorize(:red), value: "anything"
      end

      if input.downcase == "login"
        return self.login()
      elsif input.downcase == "signup"
        return self.signup()
      else
        system 'clear'
        puts "Thanks for using my program".colorize(:green)
        exit
      end
    end
  end

  def login()
    while true
      print "username: ".colorize(:light_blue)
      username = $stdin.gets.strip
      password = $prompt.mask("password:".colorize(:light_blue))
      loginid = self.hash_func(username, password)

      if @@loginids.include?(loginid)
        return loginid
      end

      input = $prompt.select("Invalid username or password".colorize(:blue)) do |menu|
        menu.choice name: "Continue".colorize(:light_blue),  value: "anything"
        menu.choice name: "Abort".colorize(:red), value: "exit"
      end
      if input == "exit"
        return self.start
      end
    end
  end

  def signup()
    while true
      print "desired username: ".colorize(:light_blue)
      username = $stdin.gets.strip

      if @@usernames.include?(username)
        input = $prompt.select("Username is already taken".colorize(:blue)) do |menu|
          menu.choice name: "Continue".colorize(:light_blue),  value: "anything"
          menu.choice name: "Abort".colorize(:red), value: "exit"
        end
        if input == "exit"
          return self.start
        end
        next
      end

      password1 = password = $prompt.mask("password:".colorize(:light_blue))
      password2 = password = $prompt.mask("confirm password:".colorize(:light_blue))

      if password1 == password2
        loginid = self.hash_func(username, password1)
        CSV.open("./data/users.csv", "a") do |csv|
          csv << [username, loginid]
        end

        @@usernames << username
        @@loginids << loginid
        return loginid
      end

      input = $prompt.select("Passwords didn't match".colorize(:blue)) do |menu|
          menu.choice name: "Continue".colorize(:light_blue),  value: "anything"
          menu.choice name: "Abort".colorize(:red), value: "exit"
        end
      if input == "exit"
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

  def slack_setup()
  end
end