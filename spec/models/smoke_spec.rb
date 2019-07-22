require 'spec_helper'

class Smoke; end

RSpec.describe Smoke do
  it 'wants all the smoke' do
    expect(true).to be true
  end
end
