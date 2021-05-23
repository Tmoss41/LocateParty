# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


group_sample_names = ['Testing Gruop 1', 'Testing Group 2', 'Testing Group 3']
group_sample_suburbs = ['Milton', 'Auchenflower', 'Mt Gravatt', 'Ipswich']
character_sample_names = ['Tim', 'Ben', 'Chelsey', 'Gill', 'Nicholas']
Profile.destroy_all
User.destroy_all
Group.destroy_all
Character.destroy_all

User.create(email: 'Test@foo.com', encrypted_password: 'Timchris2')
@user = User.first
@user.groups.create(name: 'Testing 1', suburb: 'Caloundra', state: 'QLD')
@user.groups.first.games.create(name: 'Testing Game')
@user.user_groups.first.add_role :group_admin
@user.profile.create(first_name: 'Tim', last_name: 'Moss', bio: 'I like Coding')
@user.character.create(name: 'Aragon', race: 'Human', level: 5, alignment: 'Evil', character_class: 'Bard')



# User.all.each do |user|
#     user.groups.create(name: group_sample_names.sample, suburb: group_sample_suburbs.sample , state: 'QLD' )
#     user.characters.create(name: character_sample_names.sample, race: 'Elf', character_class: 'Bard', alignment: 'Neutral', level: 1)
# end