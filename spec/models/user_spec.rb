require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'Carlos', email: 'carlos@email.com', password: '1234')
    expect(user).to be_valid
  end

  it 'isnt valid without an email' do
    user = User.new(name: 'Carlos', email: nil, password: '1234')
    expect(user).to_not be_valid
  end

  it 'isnt valid without a name' do
    user = User.new(name: nil, email: 'carlos@email.com', password: '1234')
    expect(user).to_not be_valid
  end
end
