require "date"
require "time"

class QueriesController < ApplicationController
  before_action :set_query, only: :show
  helper_method :logged_in?, :current_user

  def show
    useful_daily_info = ["summary", "temperatureMin", "temperatureMax", "windSpeed", "precipProbability", "humidity", "pressure", "windBearing"]
    useful_current_info = ["summary", "nearestStormDistance", "precipProbability", "apparentTemperature"]

    @weather = @query.get_weather
    @currently = @weather["currently"].slice(*useful_current_info)
    @daily = @weather["daily"]["data"].first.slice(*useful_daily_info)

    @summary= @weather["daily"]["summary"]

    @years = @query.get_year_array()

    historic_forecast_array = @query.get_past_weather()
    @min_temperatures = @query.make_property_list("temperatureMin", historic_forecast_array)
    @max_temperatures = @query.make_property_list("temperatureMax", historic_forecast_array)
    @wind_speed = @query.make_property_list("windSpeed", historic_forecast_array)
    @precip_prob = @query.make_property_list("precipProbability", historic_forecast_array)
  end

  def new
    @query = Query.new
    @month = sprintf '%02d', Date.today.month
    @day = sprintf '%02d', Date.today.day
    @year = Date.today.year
  end

  def create
    @query = Query.new(query_params)
    if logged_in?
      @query.users << current_user
    end
    respond_to do |format|
      if @query.save
        format.html { redirect_to @query }
        format.json { render :show, status: :created, location: @query }
      else
        format.html { render :new }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_query
      @query = Query.find(params[:id])
    end

    def query_params
      params.require(:query).permit(:address_string, :today, :month, :year, :day)
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      session[:user_id] != nil
    end

end
