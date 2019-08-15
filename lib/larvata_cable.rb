require "larvata_cable/engine"

module LarvataCable
  mattr_accessor :owner_class, :user_class, :user_account_column, :auth_token_column,
    :exp_claim_time, :leeway_claim

  def self.owner_class
    @@owner_class.constantize
  end

  def self.user_class
    @@user_class.constantize
  end

  def self.user_account_column
    @@user_account_column
  end

  def self.auth_token_column
    @@auth_token_column
  end
end
