class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    render json: { error: 'Not Authorized' }, status: 401 unless set_current_user
  end

  def set_current_user
    @current_user = AuthorizeApiRequest.call(request.headers).result
  end
end
