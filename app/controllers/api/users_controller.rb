require 'digest'
require_relative '../../helpers/application_helper'

module Api
  class Api::UsersController < ApplicationController
    include ApplicationHelper
    skip_before_action :verify_authenticity_token, only: [:create]
    def create
      user = User.find_by(email: user_params[:email])

      if user
        return render json: { error: 'Email is already taken' }, status: :unprocessable_entity
      end
    
      user = User.new(user_params)
    
      unless valid_email?(user.email)
        return render json: { error: 'Invalid email format' }, status: :unprocessable_entity
      end
    
      unless valid_password_length?(user.password)
        return render json: { error: 'Password must be at least 6 characters long' }, status: :unprocessable_entity
      end
    
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
  