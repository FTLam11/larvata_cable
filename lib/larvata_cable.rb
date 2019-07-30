require "larvata_cable/engine"

module LarvataCable
  mattr_accessor :owner_class, :user_class, :auth_token_column

  def self.owner_class
    @@owner_class.constantize
  end

  def self.user_class
    @@user_class.constantize
  end

  def self.auth_token_column
    @@auth_token_column.to_sym
  end
end
