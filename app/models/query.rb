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
    map_key = ENV["MAP_KEY"]
    map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.format_query_string}&key=#{map_key}")
    map_response = Net::HTTP.get(map_uri)
    parsed_map_response = JSON.parse(map_response)
    coordinates =  parsed_map_response["results"].first["geometry"]["location"]
    ["#{coordinates['lat']}", "#{coordinates['lng']}"]
  end

  def get_weather(date=nil)
    weather_key = ENV["WEATHER_KEY"]
    @latitude, @longitude = convert_address()
    if date
      weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{@latitude},#{@longitude},#{date}")
    else
      weather_uri = URI("https://api.forecast.io/forecast/#{weather_key}/#{@latitude},#{@longitude}")
    end
    weather_response = Net::HTTP.get(weather_uri)
    return JSON.parse(weather_response)
  end

  # add today column to model?
  def today
  end

  def create_date(year=self.year)
    month = sprintf '%02d', self.month
    day = sprintf '%02d', self.day
    "#{year}-#{month}-#{day}T00:00:00"
  end

  def get_past_dates(num_years=5)
    date_array = []
    year = self.year.to_i
    counter = 1
    until counter > num_years
      year -= counter
      date_array << create_date(year)
      counter += 1
    end
    return date_array
  end

  def get_year_array
    date_array = get_past_dates
    date_array.select{|date| date[0..3] }
    date_array.unshift("x")
  end


  def get_past_weather()
    date_array = get_past_dates()
    @weather_information = []
    parsed_info = []
    date_array.each do |date|
      full_response = get_weather(date)

      daily_response =  full_response["daily"]["data"].first
      puts daily_response.inspect
      # ideal is collection of hash objects of the form, { temperature => [12, 13, 45, 67], pressure => [110, 100, 101] }.. etc
      @weather_information << daily_response
      parsed_info << daily_response
    end
    puts @weather_information
    return @weather_information
  end

  def find_property(property, info_hash)
    return info_hash[property]
  end

  def format_past_info(info_hash)
    info_hash = info_hash.first
    formatted_hash = {}
    formatted_hash["Minimum Temperature"] = info_hash["temperatureMin"]
    # formatted_hash["Maximum Temperature"] = info_hash["temperatureMax"]
    # formatted_hash["Pressure"] = info_hash["pressure"]
    return formatted_hash
  end

  private

  def map_key
    Rails.application.secrets[:MAP_KEY]
  end

  def weather_key
    Rails.application.secrets[:WEATHER_KEY]
  end

  # not optimal that I have to validate by hitting the API
  def address_must_respond_to_api
    map_key = ENV["MAP_KEY"]
    formatted_string = self.address_string.gsub(/\s/, "+")
    map_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{formatted_string}&key=#{map_key}")
    map_response = Net::HTTP.get(map_uri)
    parsed_map_response = JSON.parse(map_response)
    if parsed_map_response["results"].empty?
      errors.add(:address_string, "is not a valid U.S. address. Please try again.")
    end
  end

end
