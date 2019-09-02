FactoryBot.define do
  sequence(:tenant_name) { |n| "tenant#{n}" }

  factory :larvata_cable_tenant, class: 'LarvataCable::Tenant', aliases: [:tenant] do
    application_id { nil }
    name { generate(:tenant_name) }
  end
end
