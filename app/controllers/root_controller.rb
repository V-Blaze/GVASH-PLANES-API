class RootController < ApplicationController
  skip_before_action :authenticate_request
  def index
    render json: { messge: 'Server running!!!' }, status: :ok
  end
end
