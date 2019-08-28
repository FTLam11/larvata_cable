require 'rails_helper'

module LarvataCable
  RSpec.describe Tenant, type: :model do
    describe 'validations' do
      it { should validate_presence_of(:application_id) }
      it { should validate_uniqueness_of(:application_id) }
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name) }
    end
  end
end
