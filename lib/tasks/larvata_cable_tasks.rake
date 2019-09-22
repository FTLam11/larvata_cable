namespace :tenants do
  desc 'Create new tenant for target host application'
  task :create, [:host_app_name] => :environment do |task, args|
    tenant = LarvataCable::Tenant.new(name: args.host_app_name)

    if tenant.save
      Rails.logger.tagged(task.name) do
        Rails.logger.info("Created new tenant: #{tenant.inspect}")
      end
    else
      Rails.logger.tagged(task.name) do
        Rails.logger.error("Failed to create tenant: '#{tenant.errors.full_messages.join(', ')}' with: #{args}")
      end
    end
  end
end

namespace :config do
  desc 'Generate new base64 encoded public/private key pair'
  task keypair: :environment do
    keypair = RbNaCl::PrivateKey.generate

    puts public_key: LarvataCable::AuthWrapper.base64_encode(keypair.public_key.to_s),
      private_key: LarvataCable::AuthWrapper.base64_encode(keypair.to_s)
  end
end
