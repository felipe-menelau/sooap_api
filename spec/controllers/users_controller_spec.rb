require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST create' do
    it 'should create user when params are valid' do
      params = {:email => 'example@mail.com', name: 'Carlos', :password => '123123123'}
      post(:create, :params => params)
      expect(response.status).to eq(201)
    end
  end
end
