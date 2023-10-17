require 'digest'
module Api
  class Api::VideosController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :find_user

    def list
        videos = @user.videos
        render json: { videos: videos }
    end

    def add_video
        video_info = params.permit(:title, :description, :url, :metadata) 
        new_video = @user.videos.new(video_info)
      
        if new_video.save
          render json: { message: 'Video added successfully' }
        else
          render json: { error: new_video.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
    end

    private

    def find_user
        @user = User.find_by(id: JwtService.decode(request.headers['Authorization'])['user_id'])
    end
  end
end
  