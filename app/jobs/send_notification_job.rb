class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(video)
    message = video.to_json
    ActionCable.server.broadcast("NotificationsChannel", {message: message})
  end
end
