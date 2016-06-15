# N.B. Probably easier to validate zip codes than full addresses

require 'net/http'
require 'json'
require 'date'
require 'time'

#THIS ALL FUCKING WORKS
map_key = Rails.application.secrets[:MAP_KEY]
test_address = ["534", "Washington", "Avenue", "Newtown", "PA"]
p "https://maps.googleapis.com/maps/api/geocode/json?address=#{test_address}&key=#{map_key}"
map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{test_address}&key=#{map_key}")
map_response = Net::HTTP.get(map_uri)
parsed_map_response = JSON.parse(map_response)
coordinates =  parsed_map_response["results"].first["geometry"]["location"]
puts coordinates
latitude = coordinates["lat"]
longitude = coordinates["lng"]
# puts "#{latitude} and #{longitude}"
# puts map_key

weather_key = Rails.application.secrets[:WEATHER_KEY]
p weather_key
# FLAWLESS FUCKING VICTORY FOR CURRENT WEATHER
weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{latitude},#{longitude}")
weather_response = Net::HTTP.get(weather_uri)
# puts weather_response
parsed_weather_response = JSON.parse(weather_response)
current_weather =  parsed_weather_response["currently"]
puts parsed_weather_response["hourly"]["summary"]
# weekly_summary =  parsed_weather_response["daily"]["summary"]

# PAST FUCKING WEATHER. IT FUCKING WORKS
# puts weather_key
# birthday = "1987-01-11T00:00:00"
# past_weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{latitude},#{longitude},#{birthday}")
# past_weather_response = Net::HTTP.get(past_weather_uri)
# parsed_past_weather_response = JSON.parse(past_weather_response)
# puts parsed_past_weather_response["currently"]