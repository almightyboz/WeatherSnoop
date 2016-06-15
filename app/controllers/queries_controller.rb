require "date"
require "time"

class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :historic]
  helper_method :logged_in?, :current_user

  def index
    @queries = Query.all
  end

  def show
    @weather = @query.get_weather
    @currently = @weather["currently"]
    @hourly = @weather["hourly"]["summary"]
    @daily = @weather["daily"]["summary"]
    @years = @query.get_year_array
    @historical = @query.get_past_weather()
    # binding.pry
    puts @historical
  end

  def new
    @query = Query.new
  end

  def create
    # different tracks if you're querying for a current address or an address and date
    if query_params["today"]
      month = Date.today.month.to_s
      day = Date.today.day.to_s
      year = Date.today.year.to_s
     @query = Query.new(address_string: query_params[:address_string].to_s,
      month: month,
      day: day,
      year: year)
     # p @query.inspect
    else
      @query = Query.new(query_params)
      # p @query.inspect
    end
    if logged_in?
      @query.users << current_user
    end
    respond_to do |format|
      if @query.save

        format.html { redirect_to @query, notice: 'Query was successfully created.' }
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
