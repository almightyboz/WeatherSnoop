WEATHORR
___

The Forecast API allows you to look up the weather anywhere on the globe, returning (where available):

Current conditions
Minute-by-minute forecasts out to 1 hour
Hour-by-hour forecasts out to 48 hours
Day-by-day forecasts out to 7 days
There are two types of API calls. A forecast request returns the current forecast (for the next week):

https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE
A time-machine request returns the observed weather at a given time (for many places, up to 60 years in the past):

https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE,TIME
___

JSON responses are in UTF-8 format (due to text summaries, which can contain Unicode characters). Please ensure that your JSON parser acts accordingly.
Never make any assumptions about the presence of data or lengths of arrays. For example, a lack of data in our data sources may cause data to be missing, and Daylight Savings Time may cause a day to consist of 23 or 25 hours (instead of the usual 24). Always check for the presence of data before trying to use it.

All numeric properties are real numbers, except for UNIX timestamps, which are (signed) integers.
Summaries on the hourly data block actually only cover up to a maximum of 24 hours, rather than the full time period in the data block. We found that covering the full 48 hours could be, in a number of circumstances, far too wordy to be practical.
Summaries and icons on daily data points actually cover the period from 4AM to 4AM, rather than the stated time period of midnight to midnight. We found that the summaries so generated were less awkward.
The Forecast Data API supports HTTP compression. We heartily recommend using it, as it will make responses much smaller over the wire. To enable it, simply add an Accept-Encoding: gzip header to your request. (Most HTTP client libraries wrap this functionality for you, please consult your library’s documentation for details. Be advised that we do not support such compression over HTTP/1.0 connections.)

IMPORTANT FOR HISTORIC WEATHER DATA
time: The UNIX time (that is, seconds since midnight GMT on 1 Jan 1970) at which this data point occurs.
_____________

GEM NOTES
Get the current forecast:

forecast = ForecastIO.forecast(37.8267, -122.423)
Get the current forecast at a given time:

forecast = ForecastIO.forecast(37.8267, -122.423, time: Time.new(2013, 3, 11).to_i)
Get the current forecast and use SI units:

forecast = ForecastIO.forecast(37.8267, -122.423, params: { units: 'si' })
The forecast(...) method will return a response that you can interact with in a more-friendly way, such as:

forecast = ForecastIO.forecast(37.8267, -122.423)
forecast.latitude
forecast.longitude
___