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
puts 'Add 20 therapists accounts with password ass password'


Patient.destroy_all
patients = FactoryBot.create_list(:patient, 15, therapist_id: Therapist.first.id)
0...5.times do |week_num|
  date = DateTime.now.beginning_of_day + week_num.weeks + 15.hours
  tmp_patients = patients.shuffle
  p week_num
  -1...3.times do |day_num|
    date += day_num.days
    0.step(6, 2) do |hour_num|
      Consultation.create(schedule_time: date + hour_num.hours, patient: tmp_patients.shift, therapist: Therapist.first)
    end
  end
end


patients = Patient.all

-3.step(0) do |week_num|
  date = DateTime.now.beginning_of_day + week_num.weeks + 10.hours
  -1.step(3) do |day_num|
    date += day_num.days
    0.step(6, 2) do |hour_num|
      FactoryBot.create(:entry, patient_id: patients.sample.id, time: date + hour_num.hours)
    end
  end
end


