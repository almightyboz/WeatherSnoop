require "spec_helper"
require "rails_helper"

describe Query do
  let(:test_query) { Query.new(address_string: "534 Washington Ave, Newtown PA", month: "01", day: "11", year: "1987") }
  let(:bad_query) { Query.new(address_string: "123 Fake Street, Springfield USA", month: "01", day: "11", year: "1987") }

  it "retrieves the weather for the current location from the API" do
    date = test_query.create_date()
    forecast = test_query.get_weather(date)
    hourly_forecast = forecast["hourly"]["summary"]
    expect(hourly_forecast).to eq("Mostly cloudy throughout the day and breezy in the evening.")
  end

  it "returns an error if the address query string is invalid" do
    date = bad_query.create_date()
    expect { bad_query.get_weather(date) }.to raise_error
  end

end