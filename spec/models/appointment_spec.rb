require 'rails_helper'

RSpec.describe Appointment, :type => :model do
  it 'is valid with valid attributes' do
    appointment = Appointment.new(client_name: 'Carlos', driver: 'fullweek', time: DateTime.now)
    expect(appointment).to be_valid
  end

  it 'isnt valid without client_name' do
    appointment = Appointment.new(client_name: nil, driver: 'fullweek', time: DateTime.now)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid without driver' do
    appointment = Appointment.new(client_name: 'Carlos', driver: nil, time: DateTime.now)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid without time' do
    appointment = Appointment.new(client_name: 'Carlos', driver: 'fullweek', time: nil)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid with unexepected driver' do
    appointment = Appointment.new(client_name: 'Carlos', driver: 'somedriver', time: DateTime.now)
    expect(appointment).to_not be_valid
  end

  it 'isnt valid when appointment with same driver exists in a half-hour interval' do
    Appointment.create(client_name: 'Carlos', driver: 'weekdays', time: DateTime.now)
    appointment = Appointment.new(client_name: 'Ricardo', driver: 'weekdays', time: DateTime.now)
    expect(appointment).to_not be_valid
  end
end
