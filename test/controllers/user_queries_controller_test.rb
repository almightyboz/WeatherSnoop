require 'test_helper'

class UserQueriesControllerTest < ActionController::TestCase
  setup do
    @user_query = user_queries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_queries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_query" do
    assert_difference('UserQuery.count') do
      post :create, user_query: {  }
    end

    assert_redirected_to user_query_path(assigns(:user_query))
  end

  test "should show user_query" do
    get :show, id: @user_query
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_query
    assert_response :success
  end

  test "should update user_query" do
    patch :update, id: @user_query, user_query: {  }
    assert_redirected_to user_query_path(assigns(:user_query))
  end

  test "should destroy user_query" do
    assert_difference('UserQuery.count', -1) do
      delete :destroy, id: @user_query
    end

    assert_redirected_to user_queries_path
  end
end
