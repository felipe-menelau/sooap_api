require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST create' do
    it 'should create user when params are valid' do
      params = {:email => 'example@mail.com', name: 'Carlos', :password => '123123123'}
      post(:create, :params => params)
      expect(response.status).to eq(201)
      expect(User.count).to eq(1)
    end

    it 'shouldnt create user when params are invalid' do
      params = { name: 'Carlos', :password => '123123123'}
      post(:create, :params => params)
      expect(response.status).to eq(422)
      expect(User.count).to eq(0)
    end
  end
end
