require "spec_helper"
require "rails_helper"

describe Query do
  let(:test_query) { Query.new(address_string: "534 Washington Ave, Newtown PA", month: "01", day: "11", year: "1987") }

  it "retrieves the weather for the current location from the API" do
    forecast = test_query.get_weather
    hourly_forecast = forecast["hourly"]["summary"]
    expect(hourly_forecast).to_eq("Light rain starting tonight.")
  end

  #TODO: write test that checks that it re-renders the page if an invalid address string is given

end