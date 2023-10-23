module ApplicationHelper
    def valid_email?(email)
        email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        email =~ email_regex
      end
  
      def valid_youtube_url?(url)
        return false unless url.present? && url =~ URI::regexp
        youtube_id = url[/[?&]v=([a-zA-Z0-9_-]{11})/, 1]
        !youtube_id.nil?
      end
  
      def valid_password_length?(password)
          password.length >= 6
      end
end
