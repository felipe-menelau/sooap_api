require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  describe 'POST create' do
    before do
      @user = User.new(name: 'Carlos', email: 'carlos@email.com', password: '1234')
      allow(controller).to receive(:authenticate_request).and_return(true)
      allow(controller).to receive(:current_user).and_return(@user)
    end
    it 'should create an appointment with valid params' do
      params = { time: '2018-12-25T19:25' }
      post(:create, :params => params)
      expect(response.status).to eq(201)
      expect(Appointment.count).to eq(1)
    end
  end
end
