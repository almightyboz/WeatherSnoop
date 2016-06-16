require 'rails_helper'

describe UsersController do

  describe 'POST #create', type: :controller do

    it "Adds a new user to the database" do
      expect{ post :create, { user: {username: "spanky", password: "password" } } }.to change(User, :count).by(1)
    end

    it "redirects newly registered user to their page" do
      post :create, { user: {username: "spanky", password: "password" } }
        expect(response.status).to eq(302)
    end

    it "redirects newly registered user to their page" do
      post :create, { user: {username: "spanky", password: "password" } }
      expect(session[:user_id]).to_not eq(nil)
    end

  end
end