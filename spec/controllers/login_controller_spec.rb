require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'POST login' do
    before do
      User.create!(email: 'example@mail.com', name: 'exemple', password: '123123123' )
    end

    it 'should login with valid params' do
      params = {email: 'exemple@mail.com', password: '123123123'}
      post(:login, params)
      expect(response.status).to eq(200)
    end
  end
end
