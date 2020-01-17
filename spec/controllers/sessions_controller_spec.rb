require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # TODO: Use FactoryBot
  let(:user) { User.create name: 'John Doe', username: 'john' }

  describe '#create' do
    it 'should login with valid credentials' do
      post :create, params: { username: user.username }

      expect(session[:user_id]).to eql(user.id)
    end

    it "shouldn't login with invalid credentials" do
      post :create, params: { username: 'invalid' }

      expect(session[:user_id]).to be_nil
      expect(response).to render_template(:new)
    end
  end

  describe '#destroy' do
    it 'should logout the current user' do
      login(user)
      delete :destroy

      expect(session[:user_id]).to be_nil
    end
  end
end
