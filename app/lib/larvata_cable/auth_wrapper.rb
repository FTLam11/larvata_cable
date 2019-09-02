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

    GENERATE_TOKEN = FN[:encrypt] >> FN[:base64_encode] >> FN[:utf8_encode]
    PARSE_TOKEN = FN[:ascii_encode] >> FN[:base64_decode] >> FN[:decrypt]

    private_constant :FN

    def generate_token(data)
      { token: GENERATE_TOKEN.call(data.to_json) }
    end

    def parse_token(params)
      JSON.parse(PARSE_TOKEN.call(params[:token]))
    end
  end
end
