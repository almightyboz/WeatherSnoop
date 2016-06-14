class Query < ActiveRecord::Base

  has_many :user_queries
  has_many :users, through: :user_queries, source: :user

  validates_presence_of :address_string

  validate :address_must_respond_to_api

  # split the user-inputted string into an array
  def split_query_string
    self.address_string.split(" ").select{ |unit| unit.to_s }
  end
  # not optimal that I have to test it by
  def address_must_respond_to_api
    map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.split_query_string}&key=#{map_key}")
    map_response = Net::HTTP.get(map_uri)
    if !map_response.kind_of? Net::HTTPSuccess
      errors.add(:address_string, "is not a valid U.S. address. Please try again.")
    end
  end

  def convert_address
    map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.split_query_string}&key=#{map_key}")
    map_response = Net::HTTP.get(map_uri)
    parsed_map_response = JSON.parse(map_response)
    coordinates =  parsed_map_response["results"].first["geometry"]["location"]
    ["#{coordinates['lat']}", "#{coordinates['lng']}"]
  end

  # search for weather with longitude and latitude
  def get_parsed_weather
    latitude = convert_address[0]
    longitude = convert_address[1]
    # weather_key = ENV["WEATHER_KEY"]
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

  # get it as a JSON document, so I can use the JSON objects with D3?
  def get_past_weather(date)
    weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{LATITUDE},#{LONGITUDE},#{self.create_date}")
    weather_response = Net::HTTP.get(weather_uri)
    JSON.parse(weather_response)
  end

  private

  def map_key
    Rails.application.secrets[:MAP_KEY]
  end

  def weather_key
    Rails.application.secrets[:WEATHER_KEY]
  end

end
