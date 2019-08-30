require "larvata_cable/engine"

module LarvataCable
  mattr_accessor :exp_claim_time, :leeway_claim, :private_key, :public_key, :auth_box
end
