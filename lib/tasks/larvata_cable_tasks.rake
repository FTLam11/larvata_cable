namespace :tenants do
  desc 'Create new tenant for target host application'
  task :create, [:host_app_name] => :environment do |task, args|
    # TODO Use tagged logging
    tenant = LarvataCable::Tenant.new(name: args.host_app_name)

    if tenant.save
      p tenant
    else
      print tenant.errors.full_messages.join(', ')
    end
  end
end
