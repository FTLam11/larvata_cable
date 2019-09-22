module LarvataCable
  module AuthWrapper
    extend self

    FN = {
      encrypt: ->(data) { LarvataCable.auth_box.encrypt(data) },
      base64_encode: ->(data) { Base64.encode64(data) },
      utf8_encode: ->(data) { data.encode('UTF-8', 'ASCII-8BIT') },
      ascii_encode: ->(data) { data.encode('ASCII-8BIT', 'UTF-8') },
      base64_decode: ->(data) { Base64.decode64(data) },
      decrypt: ->(data) { LarvataCable.auth_box.decrypt(data) },
    }.freeze

    BASE64_ENCODE = FN[:base64_encode]
    GENERATE_TOKEN = FN[:encrypt] >> BASE64_ENCODE >> FN[:utf8_encode]
    READ_KEY = FN[:ascii_encode] >> FN[:base64_decode]
    PARSE_TOKEN = READ_KEY >> FN[:decrypt]

    private_constant :FN, :BASE64_ENCODE, :GENERATE_TOKEN, :READ_KEY, :PARSE_TOKEN

    def generate_token(data)
      { token: GENERATE_TOKEN.call(data.to_json) }
    end

    def parse_token(params)
      JSON.parse(PARSE_TOKEN.call(params[:token]))
    end

    def read_key(env_key)
      READ_KEY.call(env_key)
    end

    def base64_encode(data)
      BASE64_ENCODE.call(data)
    end
  end
end
