require 'rails_helper'

RSpec.describe 'rake tenants:create' do
  context 'with a new host application name' do
    it 'creates a new tenant' do
      args = task_args.new('LarvataApp')

      task.execute(args)
      tenant = LarvataCable::Tenant.where(name: 'LarvataApp')

      expect(tenant.exists?).to be true
    end
  end

  context 'with a duplicate host application name' do
    it 'displays validation errors' do
      create(:tenant, name: 'LarvataApp')
      args = task_args.new('LarvataApp')

      duplicate_tenant = build(:tenant, name: 'LarvataApp')
      duplicate_tenant.save

      expect { task.execute(args) }.to output(/Failed to create tenant:/).to_stdout_from_any_process
    end
  end

  context 'with no host application name' do
    it 'displays validation errors' do
      invalid_tenant = build(:tenant, name: nil)
      invalid_tenant.save

      expect { task.execute }.to output(/Failed to create tenant:/).to_stdout_from_any_process
    end
  end
end
