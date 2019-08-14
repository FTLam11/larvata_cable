puts "Seed start"

falcon = User.find_or_create_by(account: 'Falcon', password: '12345678')
melee = falcon.chat_rooms.create(name: 'Melee', owner: falcon)
falco = User.find_or_create_by(account: 'Falco', password: '12345678')
melee.members << falco
melee.messages.create(sender: falcon, body: 'FALCON PAWNCH')
melee.messages.create(sender: falco, body: 'AWAAAAAAAAA')
melee.messages.create(sender: falcon, body: 'SHOW YOUR MOVES')

puts "Seed finish"
