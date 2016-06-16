require 'rails_helper'

describe SessionController do
  let!(:user) {User.create!(username: "spanky", password: "password")}

  describe 'POST #create', type: :controller  do

    it 'posts an error if password is invalid' do
      post :create, {session: { username: "spanky", password: 'invalid' } }
      expect(response).to render_template(:new)
      expect(flash[:notice]).to eq("Oops, please try again")
    end

    it "creates a session cookie and redirects if the password is valid" do
      post :create, {session: { username: "spanky", password: 'password' } }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(user_url(user))
        expect(session[:user_id]).to eq(user.id)
    end
  end
end