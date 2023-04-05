class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: %i[show destroy]

  def index; end

  def show
    render json: @user, status: :ok
  end

  def create
    p user_params

    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash.to_json, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:email, :name, :password)
  end
end
