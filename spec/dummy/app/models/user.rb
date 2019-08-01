class User < ApplicationRecord
  validates_presence_of :account
  validates_uniqueness_of :account
end
