require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'should reject when without a host' do
    event = Event.new date: Time.now, description: 'An event'
    expect(event.valid?).to eql(false)
  end

  it 'should accept when given a valid host, date and description' do
    host = User.new name: 'John Doe', username: 'john_doe'
    expect(host.valid?).to eql(true)
    event = Event.new date: Time.now, description: 'An event', host: host
    expect(event.valid?).to eql(true)
  end
end
