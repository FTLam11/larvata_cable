puts "Seed start"

falcon = User.find_or_create_by(account: 'Falcon')
melee = falcon.chat_rooms.create(name: 'Melee', owner: falcon)
falco = User.find_or_create_by(account: 'Falco')
melee.members << falco
melee.messages.create(sender: falcon, body: 'FALCON PAWNCH')
melee.messages.create(sender: falco, body: 'AWAAAAAAAAA')
melee.messages.create(sender: falcon, body: 'SHOW YOUR MOVES')

puts "Seed finish"
