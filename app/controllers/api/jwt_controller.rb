require 'digest'

module Api
    class Api::JwtController < ApplicationController
        skip_before_action :verify_authenticity_token, only: [:login]
        def login
            user = User.find_by(email: params[:email])
            hashed_password = Digest::SHA256.hexdigest(params[:password])
            logger.debug("Hashed Password debug " + hashed_password)
            logger.debug("Database Password " + user.password)
            if user && user.password == hashed_password
                token = JwtService.encode(user_id: user.id)
                render json: { auth_token: token }
            else
                render json: { error: 'Invalid email or password' }, status: :unauthorized
            end
        end
    end
end