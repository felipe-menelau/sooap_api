require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  before do
    @user = User.new(name: 'Carlos', email: 'carlos@email.com', password: '1234')
    allow(controller).to receive(:authenticate_request).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user)
  end

  describe 'POST create' do
    it 'should create an appointment with valid params' do
      params = { time: '2018-12-25T19:25' }
      post(:create, :params => params)
      expect(response.status).to eq(201)
      expect(Appointment.count).to eq(1)
    end

    it 'shouldnt create appointment when there are no drivers' do
      Appointment.create(client_name: 'Carlos', client_id: @user.id, driver: 'fullweek', time: '2018-12-23T19:20')
      params = { time: '2018-12-23T19:25' }
      post(:create, :params => params)
      expect(response.status).to eq(422)
      expect(Appointment.count).to eq(1)
    end

    it 'shouldnt create appointment with no time' do
      post(:create)
      expect(response.status).to eq(422)
      expect(Appointment.count).to eq(0)
    end

    it 'should create 2 appointments in similar times if on weekday' do
      Appointment.create(client_name: 'Carlos', client_id: @user.id, driver: 'fullweek', time: '2018-12-25T19:20')
      params = { time: '2018-12-25T19:25' }
      post(:create, :params => params)
      expect(response.status).to eq(201)
      expect(Appointment.count).to eq(2)
    end
  end

  describe 'GET index' do
    it 'should list all appointments' do
      Appointment.create(client_name: 'Carlos', client_id: @user.id, driver: 'fullweek', time: '2018-12-25T19:20')
      get(:index)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['appointments'].size).to eq(1)
    end
  end

  describe 'DELTE delete' do
    it 'should delete existing appointment' do
      appointment = Appointment.create(client_name: 'Carlos', client_id: @user.id, driver: 'fullweek', time: '2018-12-25T19:20')
      delete(:destroy, :params => {:id => appointment.id.to_s})
      expect(response.status).to eq(204)
      expect(Appointment.count).to eq(0)
    end
  end
end
