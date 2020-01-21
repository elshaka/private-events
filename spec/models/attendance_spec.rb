require 'rails_helper'

RSpec.describe Attendance, type: :model do
  it 'should reject when not given anything' do
    attendance = Attendance.new
    expect(attendance.valid?).to eql(false)
  end

  it 'should reject when not given an attendee user' do
    user = User.new name: 'John Doe', username: 'john_doe'
    expect(user.valid?).to eql(true)
    event = Event.new date: Time.now, description: 'An event', host: user
    expect(event.valid?).to eql(true)
    attendance = Attendance.new event: event
    expect(attendance.valid?).to eql(false)
  end

  it 'should accept when given an attendee user and an event' do
    user = User.new name: 'John Doe', username: 'john_doe'
    expect(user.valid?).to eql(true)
    event = Event.new date: Time.now, description: 'An event', host: user
    expect(event.valid?).to eql(true)
    attendance = Attendance.new event: event, user: user
    expect(attendance.valid?).to eql(true)
  end
end
