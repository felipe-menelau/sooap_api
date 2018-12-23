require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'POST login' do
    before do
      User.create!(email: 'example@mail.com', name: 'exemple', password: '123123123' )
    end

    it 'should login with valid params' do
      params = {:email => 'example@mail.com', :password => '123123123'}
      post(:login, :params => params)
      expect(response.status).to eq(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['auth_token']).to be
    end

    it 'shouldnt login with invalid params' do
      params = {:email => 'example@mail.com', :password => 'errado'}
      post(:login, :params => params)
      expect(response.status).to eq(401)
    end
  end
end
