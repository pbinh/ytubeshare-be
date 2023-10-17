require 'digest'
module Api
  class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
    def create
      user = User.new(user_params)
      user.password = Digest::SHA256.hexdigest(user.password)
      if user.save
        render json: { message: 'User registered successfully' }
      else
        render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
    
    private
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
  