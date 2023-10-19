module YtubeshareBe
  class JwtAuthentication
      WHITE_LIST = ['api/register', 'api/login', 'cable']

      def initialize(app)
        @app = app
      end
    
      def call(env)
        request = Rack::Request.new(env)
    
        unless whitelisted?(request.path_info)
          token = request.env['HTTP_AUTHORIZATION']
          if token.blank? || !JwtService.valid_token?(token)
            return [401, { 'Content-Type' => 'application/json' }, [{ error: 'Unauthorized' }.to_json]]
          end
        end
    
        @app.call(env)
      end
    
      private
    
      def whitelisted?(path)
          WHITE_LIST.each do |substring|
              return true if path.include?(substring)
          end
          false
      end
  end
end
  