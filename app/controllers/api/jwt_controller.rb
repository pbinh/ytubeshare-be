module Api
    class Api::JwtController < ApplicationController
        skip_before_action :verify_authenticity_token, only: [:login]
        def login
            user = User.find_by(email: params[:email])
            if user && user.password == params[:password]
                token = JwtService.encode(user_id: user.id)
                render json: { auth_token: token }
            else
                render json: { error: 'Invalid email or password' }, status: :unauthorized
            end
        end
    end
end