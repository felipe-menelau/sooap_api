require 'rails_helper'

RSpec.describe Appointment, :type => :model do
  it 'is valid with valid attributes' do
    appointment = Appointment.new(client_name: 'Carlos', driver: 'fullweek', time: DateTime.now)
    expect(appointment).to be_valid
  end
end
