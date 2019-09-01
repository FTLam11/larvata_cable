module LarvataCable
  module AuthWrapper
    extend self

    # Upgrade Ruby to use function piping feature

    def generate_token(data)
      encrypted = LarvataCable.auth_box.encrypt(data.to_json)
      encoded = Base64.encode64(encrypted)
      utf_8 = encoded.encode('UTF-8', 'ASCII-8BIT')

      { token: utf_8 }
    end

    def parse_token(params)
      binary = params[:token].encode('ASCII-8BIT', 'UTF-8')
      decoded = Base64.decode64(binary)
      decrypted = LarvataCable.auth_box.decrypt(decoded)
      JSON.parse(decrypted)
    end
  end
end
