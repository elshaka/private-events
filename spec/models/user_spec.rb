require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should reject empty names' do
    user = User.new username: 'john_doe'
    expect(user.valid?).to eql(false)
  end

  it 'should reject empty user names' do
    user = User.new name: 'John Doe'
    expect(user.valid?).to eql(false)
  end

  it 'should accept users with proper names and usernames' do
    user = User.new name: 'John Doe', username: 'john_doe'
    expect(user.valid?).to eql(true)
  end
end
