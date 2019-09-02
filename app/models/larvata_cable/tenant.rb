module LarvataCable
  class Tenant < ApplicationRecord
    validates_presence_of :name
    validates_uniqueness_of :application_id, :name, case_sensitive: true

    before_create :generate_application_id

    private

    def generate_application_id
      self.application_id = SecureRandom.uuid
    end
  end
end
