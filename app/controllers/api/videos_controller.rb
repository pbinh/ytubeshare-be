require 'digest'
module Api
  class Api::VideosController < ApplicationController
    before_action :find_user

    def list
        videos = @user.videos
        render json: { videos: videos }
    end

    private

    def find_user
        @user = User.find_by(id: JwtService.decode(request.headers['Authorization'])['user_id'])
    end
  end
end
  