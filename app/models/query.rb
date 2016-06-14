class Query < ActiveRecord::Base
  # would be easy to perform validations and keep info consistent if the user supplies zip codes instead of street addresses
  #TODO alternative if the address doesn't return a valid search when it hits the API (concern, this may mean many calls to the API, better to do server-side validation before it hits the API)
  has_many :user_queries
  has_many :users, through: :user_queries, source: :user

  # split the user-inputted string into an array
  def split_query_string
    self.address_string.split(" ").select{ |unit| unit.to_s }
  end

  def convert_address
    map_key = ENV["map_key"]
    map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.split_query_string}&key=#{map_key}")
    map_response = Net::HTTP.get(map_uri)
    parsed_map_response = JSON.parse(map_response)
    coordinates =  parsed_map_response["results"].first["geometry"]["location"]
    latitude = coordinates["lat"]
    longitude = coordinates["lng"]
  end

  # search for weather with longitude and latitude
  def get_parsed_weather
    weather_key = ENV["weather_key"]
    weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{latitude},#{longitude}")
    weather_response = Net::HTTP.get(weather_uri)
    JSON.parse(weather_response)
    # parsed_weather_response = JSON.parse(weather_response)
    # current_weather =  parsed_weather_response["currently"]
    # today_summary = parsed_weather_response["hourly"]["summary"]
  end

  def today
  end

  def create_date
    "#{self.year}-#{self.month}-#{self.day}T00:00:00"
  end

  # def current_weather
  #   self.get_parsed_weather["currently"]
  # end

  # def daily_forecast
  #   self.get_parsed_weather["hourly"]
  # end

  # def weekly_forecast
  #   self.get_parsed_weather["daily"]
  # end

  # get it as a JSON document, so I can use the JSON objects with D3?
  def get_past_weather(date)
    weather_key = ENV["weather_key"]
    weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{latitude},#{longitude},#{self.create_date}")
    weather_response = Net::HTTP.get(weather_uri)
    JSON.parse(weather_response)
  end

end
