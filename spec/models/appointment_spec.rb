require 'rails_helper'

RSpec.describe Appointment, :type => :model do
  before do
    @user = User.new(name: 'Carlos', email: 'carlos@email.com', password: '1234')
  end

  it 'is valid with valid attributes' do
    appointment = Appointment.new(client_name: 'Carlos', client_id: @user.id, driver: 'fullweek', time: DateTime.now)
    expect(appointment).to be_valid
  end

  it 'isnt valid without client_name' do
    appointment = Appointment.new(client_name: nil, client_id: @user.id, driver: 'fullweek', time: DateTime.now)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid without driver' do
    appointment = Appointment.new(client_name: 'Carlos', client_id: @user.id, driver: nil, time: DateTime.now)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid without time' do
    appointment = Appointment.new(client_name: 'Carlos', client_id: @user.id, driver: 'fullweek', time: nil)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid with unexepected driver' do
    appointment = Appointment.new(client_name: 'Carlos', client_id: @user.id, driver: 'somedriver', time: DateTime.now)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid when appointment with same driver exists in a half-hour interval' do
    Appointment.create(client_name: 'Carlos', client_id: @user.id, driver: 'weekdays', time: DateTime.now)
    appointment = Appointment.new(client_name: 'Ricardo', client_id: @user.id, driver: 'weekdays', time: DateTime.now)
    expect(appointment).to_not be_valid
  end

  it 'should create 2 appointments for the same driver if they are more then half-hour apart' do
    Appointment.create(client_name: 'Carlos', client_id: @user.id, driver: 'weekdays', time: DateTime.now)
    Appointment.create(client_name: 'Ricardo', client_id: @user.id, driver: 'weekdays', time: DateTime.now + 50.minutes)
    expect(Appointment.count).to eq(2)
  end
end
