

x = File.open("./data/default").each do |line|
  p line.length
end
p x
# require_relative '../token/token.rb'
# require "uri"
# require "net/http"
# require 'json'


# url = URI("https://slack.com/api/users.list")

# https = Net::HTTP.new(url.host, url.port);
# https.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["Content-Type"] = "application/x-www-form-urlencoded"
# request["Authorization"] = Auth::BotUserToken
# request.body = "="

# response = https.request(request)
# a = response.read_body
# my_hash = JSON.parse(a)
# pp my_hash

# url = URI("https://slack.com/api/chat.postMessage")

# https = Net::HTTP.new(url.host, url.port);
# https.use_ssl = true

# request = Net::HTTP::Post.new(url)
# request["Content-Type"] = "application/json"
# request["Authorization"] = Auth::BotUserToken
# form_data = [['channel', '#general'],['text', 'hello world']]
# request.set_form form_data, 'multipart/form-data'
# response = https.request(request)
# puts response.read_body