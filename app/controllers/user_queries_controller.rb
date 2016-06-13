class UserQueriesController < ApplicationController
  before_action :set_user_query, only: [:show, :edit, :update, :destroy]

  # GET /user_queries
  # GET /user_queries.json
  def index
    @user_queries = UserQuery.all
  end

  # GET /user_queries/1
  # GET /user_queries/1.json
  def show
  end

  # GET /user_queries/new
  def new
    @user_query = UserQuery.new
  end

  # GET /user_queries/1/edit
  def edit
  end

  # POST /user_queries
  # POST /user_queries.json
  def create
    @user_query = UserQuery.new(user_query_params)

    respond_to do |format|
      if @user_query.save
        format.html { redirect_to @user_query, notice: 'User query was successfully created.' }
        format.json { render :show, status: :created, location: @user_query }
      else
        format.html { render :new }
        format.json { render json: @user_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_queries/1
  # PATCH/PUT /user_queries/1.json
  def update
    respond_to do |format|
      if @user_query.update(user_query_params)
        format.html { redirect_to @user_query, notice: 'User query was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_query }
      else
        format.html { render :edit }
        format.json { render json: @user_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_queries/1
  # DELETE /user_queries/1.json
  def destroy
    @user_query.destroy
    respond_to do |format|
      format.html { redirect_to user_queries_url, notice: 'User query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_query
      @user_query = UserQuery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_query_params
      params.fetch(:user_query, {})
    end
end
