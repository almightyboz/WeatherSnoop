batch_forecasts = [{"time"=>1276574400, "summary"=>"Mostly cloudy overnight.", "icon"=>"partly-cloudy-night", "sunriseTime"=>1276594253, "sunsetTime"=>1276648333, "moonPhase"=>0.12, "precipIntensity"=>0, "precipIntensityMax"=>0, "precipProbability"=>0, "temperatureMin"=>65.94, "temperatureMinTime"=>1276657200, "temperatureMax"=>78.63, "temperatureMaxTime"=>1276635600, "apparentTemperatureMin"=>65.94, "apparentTemperatureMinTime"=>1276657200, "apparentTemperatureMax"=>78.63, "apparentTemperatureMaxTime"=>1276635600, "dewPoint"=>55.77, "humidity"=>0.59, "windSpeed"=>3.18, "windBearing"=>79, "visibility"=>9.95, "cloudCover"=>0.13, "pressure"=>1016.94}, {"time"=>1150344000, "summary"=>"Partly cloudy in the afternoon.", "icon"=>"partly-cloudy-day", "sunriseTime"=>1150363853, "sunsetTime"=>1150417934, "moonPhase"=>0.64, "precipIntensity"=>0, "precipIntensityMax"=>0, "precipProbability"=>0, "temperatureMin"=>60.45, "temperatureMinTime"=>1150365600, "temperatureMax"=>79.42, "temperatureMaxTime"=>1150416000, "apparentTemperatureMin"=>60.45, "apparentTemperatureMinTime"=>1150365600, "apparentTemperatureMax"=>79.42, "apparentTemperatureMaxTime"=>1150416000, "dewPoint"=>52.2, "humidity"=>0.57, "windSpeed"=>7.81, "windBearing"=>324, "visibility"=>9.63, "cloudCover"=>0.21, "pressure"=>1013.34}, {"time"=>992577600, "summary"=>"Rain starting in the afternoon, continuing until evening.", "icon"=>"rain", "sunriseTime"=>992597454, "sunsetTime"=>992651541, "moonPhase"=>0.8, "precipIntensity"=>0.0396, "precipIntensityMax"=>0.1882, "precipIntensityMaxTime"=>992649600, "precipProbability"=>0.76, "precipType"=>"rain", "temperatureMin"=>70.06, "temperatureMinTime"=>992595600, "temperatureMax"=>82.2, "temperatureMaxTime"=>992631600, "apparentTemperatureMin"=>70.06, "apparentTemperatureMinTime"=>992595600, "apparentTemperatureMax"=>87.14, "apparentTemperatureMaxTime"=>992631600, "dewPoint"=>71.33, "humidity"=>0.88, "windSpeed"=>6.42, "windBearing"=>90, "visibility"=>6.85, "cloudCover"=>0.77, "pressure"=>1017.75}]
single_forecast = {"time"=>1150344000, "summary"=>"Partly cloudy in the afternoon.", "icon"=>"partly-cloudy-day", "sunriseTime"=>1150363853, "sunsetTime"=>1150417934, "moonPhase"=>0.64, "precipIntensity"=>0, "precipIntensityMax"=>0, "precipProbability"=>0, "temperatureMin"=>60.45, "temperatureMinTime"=>1150365600, "temperatureMax"=>79.42, "temperatureMaxTime"=>1150416000, "apparentTemperatureMin"=>60.45, "apparentTemperatureMinTime"=>1150365600, "apparentTemperatureMax"=>79.42, "apparentTemperatureMaxTime"=>1150416000, "dewPoint"=>52.2, "humidity"=>0.57, "windSpeed"=>7.81, "windBearing"=>324, "visibility"=>9.63, "cloudCover"=>0.21, "pressure"=>1013.34}

def get_key(property, input_hash)
  input_hash[property]
end

puts get_key("pressure", single_forecast)

def make_key_list(property, hash_array)
  key_list = [property]
  hash_array.each do |hash|
    key_list << get_key(property, hash)
  end
  return key_list
end

puts make_key_list("cloudCover", batch_forecasts).inspect