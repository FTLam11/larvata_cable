module LarvataCable
  class Tenant < ApplicationRecord
    validates_presence_of :application_id, :name
    validates_uniqueness_of :application_id, :name
  end
end
