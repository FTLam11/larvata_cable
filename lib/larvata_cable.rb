require "larvata_cable/engine"

module LarvataCable
  mattr_accessor :owner_class, :user_class

  def self.owner_class
    @@owner_class.constantize
  end

  def self.user_class
    @@user_class.constantize
  end
end
