# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

hometowns = [
  'Amarata',
  'Okaka',
  'Ekiki',
  'Opolo',
  'Tombia',
  'Azikoro',
  'Kpansia',
  'Agudama'
]

states = [
  'Bayelsa', 
  'Rivers',
  'Delta',
  'Edo',
  'Imo',
  'Anambra',
]

[
  'Jake Peralta',
  'James Fraco',
  'Charls Boyle',
  'Raymond Holt',
  'Ricky Sanchez',
  'Bibi Aremieye',
  'Azibalua Emakitor',
  'Biggie Smalls',
  'Tupac Sharkur',
  'Drake Drake',
  'Burna Boy',
  'Timaya Timaya',
  'Godstar Gerald',
  'Harmony Ronaldo'
].each do |name|
  Driver.create(
    name: name,
    phone_number: '09094838283',
    mot_number: rand(10000),
    address: 'Yenegoa',
    area_of_operation: hometowns.sample,
    hometown: hometowns.sample,
    state: states.sample
  )
end
