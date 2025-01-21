require 'json'
require 'open-uri'
require 'pry'

file = File.open(File.join(__dir__, 'users_gpt_sans_images.json'))
data = file.read

users = JSON.parse(data)

users_with_images = []
puts(users.length)
users.each do |user|
  gender = user['gender'].downcase
  resp = URI.open("https://randomuser.me/api/?inc=picture&gender=#{gender}&noinfo", &:read)
  data = JSON.parse(resp)
  user['picture'] = data['results'][0]['picture']
  users_with_images.push(user)
end

File.open(File.join(__dir__, 'users_gpt.json'), 'w') { |f| f.write JSON.generate(users_with_images) }
