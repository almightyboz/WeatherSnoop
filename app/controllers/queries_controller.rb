class QueriesController < ApplicationController
  before_action :set_query, only: :show

  def index
    @queries = Query.all
  end

  def show
  end

  def new
    @query = Query.new
  end

  def create
    # different tracks if you're querying for a current address or an address and date
    @query = Query.new(query_params)

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
      params.fetch(:query, {})
    end
end
