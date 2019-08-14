class User < ApplicationRecord
  devise :database_authenticatable

  validates_presence_of :account
  validates_uniqueness_of :account
end
