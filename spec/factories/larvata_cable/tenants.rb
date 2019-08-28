FactoryBot.define do
  factory :larvata_cable_tenant, class: 'LarvataCable::Tenant', aliases: [:tenant] do
    application_id { nil }
    name { "Tenant" }
  end
end
