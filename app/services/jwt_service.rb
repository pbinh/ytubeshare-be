class JwtService
    def self.encode(payload)
        JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
    end
  
    def self.decode(token)
        begin
            decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, false, algorithm: 'HS256')
            payload = decoded_token.first
        rescue JWT::DecodeError, JWT::VerificationError
            return nil
        end
        
        payload
    end

    def self.valid_token?(token)
        return false if token.blank?
    
        begin
            decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, false, algorithm: 'HS256')
            payload = decoded_token.first
            
            if payload['exp'] && payload['exp'] < Time.now.to_i
                return false
            end
        
            rescue JWT::DecodeError
                return false
            rescue JWT::VerificationError
                return false
        end
    
        true
    end
end
  