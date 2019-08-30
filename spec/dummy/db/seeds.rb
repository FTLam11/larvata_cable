puts "Seed start"

tenant = LarvataCable::Tenant.create(name: 'LarvataApp')
falcon = LarvataCable::User.find_or_create_by(host_user_id: 1, tenant: tenant)
melee = falcon.chat_rooms.create(name: 'Melee', owner: falcon, tenant: tenant)
falco = LarvataCable::User.find_or_create_by(host_user_id: 2, tenant: tenant)
melee.members << falco
melee.messages.create(sender: falcon, body: 'FALCON PAWNCH')
melee.messages.create(sender: falco, body: 'AWAAAAAAAAA')
melee.messages.create(sender: falcon, body: 'SHOW YOUR MOVES')

puts "Seed finish"
