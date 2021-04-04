# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Purge the database'
Patient.destroy_all
Entry.destroy_all
puts '-----------'
puts 'Add 30 accounts with password as password'
FactoryBot.create_list(:patient, 30)
FactoryBot.create(:patient, email: 'test@gmail.com')
FactoryBot.create(:patient, email: 'test2@gmail.com')
puts 'Add test@gmail.com and test2@gmail.com accounts with password as password'
puts '-----------'
Patient.all.each do |patient|
  FactoryBot.create_list(:entry, 20, patient: patient)
end

puts "#{Entry.count} entries created successfully, 20 by patient"

puts '-----------'
FactoryBot.create_list(:therapist, 20)
puts 'Add 20 therapists accounts with password ass password'
