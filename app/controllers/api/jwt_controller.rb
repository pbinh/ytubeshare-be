require 'digest'
require_relative '../../helpers/application_helper'

module Api
    class Api::JwtController < ApplicationController
        include ApplicationHelper
        skip_before_action :verify_authenticity_token, only: [:login]
        def login
            user = User.find_by(email: params[:email])
            hashed_password = Digest::SHA256.hexdigest(params[:password])

            unless valid_email?(params[:email])
                return render json: { error: 'Invalid email format' }, status: :unprocessable_entity
            end

            unless valid_password_length?(params[:password])
                return render json: { error: 'Password must be at least 6 characters long' }, status: :unprocessable_entity
            end

            if user && user.password == hashed_password
                token = JwtService.encode(user_id: user.id)
                render json: { auth_token: token }
            else
                render json: { error: 'Invalid email or password' }, status: :unauthorized
            end
        end
    end
end