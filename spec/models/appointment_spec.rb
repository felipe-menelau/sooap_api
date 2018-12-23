require 'rails_helper'

Rspec.describe Appointment, :type => :model do
  it 'is valid with valid attributes' do
    appointment = Appointment.new(client_name: 'Carlos', driver: 'fullweek', time: DateTime.now)
  end
end
