FactoryBot.define do
  factory :larvata_cable_tenant, class: 'Tenant' do
    application_id { "123456789" }
    name { "Tenant" }
  end
end
