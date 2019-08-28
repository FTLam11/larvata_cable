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
      errors = duplicate_tenant.errors.full_messages.join(', ')

      expect { task.execute(args) }.to output(errors).to_stdout
    end
  end

  context 'with no host application name' do
    it 'displays validation errors' do
      invalid_tenant = build(:tenant, name: nil)
      invalid_tenant.save
      errors = invalid_tenant.errors.full_messages.join(', ')

      expect { task.execute }.to output(errors).to_stdout
    end
  end
end
