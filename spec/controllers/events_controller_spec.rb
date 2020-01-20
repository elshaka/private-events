require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  # TODO Use FactoryBot
  let(:user) { User.create name: 'John Doe', username: 'john' }
  let(:other_user) { User.create name: 'Jack Johnson', username: 'jack' }
  let!(:future_event) { other_user.hosted_events.create! description: 'Some new event description', date: 1.week.from_now }
  let!(:past_event) { other_user.hosted_events.create! description: 'Some old event description', date: 1.week.ago }

  describe '#index' do
    before { get :index }

    it 'should list upcoming events' do
      expect(assigns(:upcoming_events).first).to eql(future_event)
    end

    it 'should list past events' do
      expect(assigns(:prev_events).first).to eql(past_event)
    end
  end

  describe '#show' do
    it 'should show the event' do
      get :show, params: { id: future_event.id }
      expect(response).to have_http_status(200)
    end
  end

  context 'when logged in' do
    before { login(user) }

    describe '#create' do
      it 'should create an event hosted by the current user' do
        expect(user.hosted_events.empty?).to eql(true)
        post :create, params: { event: { description: "Next Weekly Meeting", date: 1.week.from_now } }
        expect(user.hosted_events.empty?).to eql(false)
      end
    end

    describe '#join' do
      it 'should add the current user as an atendee to the event' do
        expect(user.attending_events.empty?).to eql(true)
        post :join, params: { id: future_event.id }
        expect(user.attending_events.empty?).to eql(false)
      end
    end

    describe '#leave' do
      it 'should remove the current user event atendees' do
        expect(user.attending_events.empty?).to eql(true)
        post :join, params: { id: future_event.id }
        expect(user.attending_events.empty?).to eql(false)
        post :leave, params: { id: future_event.id }
        expect(user.attending_events.empty?).to eql(true)
      end
    end
  end

  context 'when not logged in' do
    describe '#new' do
      it 'should redirect to the log-in form page' do
        get :new

        expect_redirect_to_login
      end
    end

    describe '#create' do
      it 'should redirect to the log-in form page' do
        post :create
        expect_redirect_to_login
      end
    end

    describe '#join' do
      it 'should redirect to the log-in form page' do
        post :join, params: { id: future_event.id }
        expect_redirect_to_login
      end
    end

    describe '#leave' do
      it 'should redirect to the log-in form page' do
        post :leave, params: { id: future_event.id }
        expect_redirect_to_login
      end
    end
  end
end
