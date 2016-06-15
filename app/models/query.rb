class Query < ActiveRecord::Base

  has_many :user_queries
  has_many :users, through: :user_queries, source: :user

  validates_presence_of :address_string

  validate :address_must_respond_to_api

  # replaces spaces in the user's string with plus signs
  def format_query_string
    self.address_string.gsub(/\s/, "+")
  end

  def convert_address
    map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.format_query_string}&key=#{map_key}")
    map_response = Net::HTTP.get(map_uri)
    parsed_map_response = JSON.parse(map_response)
    coordinates =  parsed_map_response["results"].first["geometry"]["location"]
    ["#{coordinates['lat']}", "#{coordinates['lng']}"]
  end

  def get_weather
    latitude = convert_address[0]
    longitude = convert_address[1]
    weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{latitude},#{longitude}")
    Net::HTTP.get(weather_uri)
    # JSON.parse(weather_response)
  end

  # search for weather with longitude and latitude
  def get_parsed_weather
    weather_response = get_weather()
    JSON.parse(weather_response)
  end

  # add today column to model?
  def today
  end

  def create_date(year=self.year)
    "#{year}-#{self.month}-#{self.day}T00:00:00"
  end

  # get it as a JSON document, so I can use the JSON objects with D3?
  def get_past_dates(num_years=5)
    date_array = []
    year = self.year
    counter = 1
    until counter > num_years
      year -= counter
      date_array << create_date(year)
      counter += 1
    end
    return date_array
  end

  # def get_past_weather()
  #   date_array = get_past_dates()
  # end

  private

  def map_key
    Rails.application.secrets[:MAP_KEY]
  end

  def weather_key
    Rails.application.secrets[:WEATHER_KEY]
  end

  # not optimal that I have to test it by hitting the API
  def address_must_respond_to_api
    formatted_string = self.address_string.gsub(/\s/, "+")
    map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{formatted_string}&key=#{map_key}")
    map_response = Net::HTTP.get(map_uri)
    parsed_map_response = JSON.parse(map_response)
    if parsed_map_response["results"].empty?
      errors.add(:address_string, "is not a valid U.S. address. Please try again.")
    end
  end

end
