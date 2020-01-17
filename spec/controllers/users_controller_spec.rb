require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # TODO Use FactoryBot
  let(:user) { User.create name: 'John Doe', username: 'john' }
  let(:new_user) { User.new name: 'Jack Johnson', username: 'jack' }

  describe '#create' do
    it 'should create a new user' do
      post :create, params: {user: { name: new_user.name, username: new_user.username }}

      expect(User.last.name).to eql(new_user.name)
    end
  end

  describe '#show' do
    context 'when logged in' do
      before { login(user) }
      it "should show the current user profile" do
        get :show

        expect(response).to render_template(:show)
      end
    end

    context 'when not logged in' do
      it "should redirect to login path" do
        get :show

        expect_redirect_to_login
      end
    end
  end
end
