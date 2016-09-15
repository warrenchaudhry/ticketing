# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..5).each do |i|
  customer = User.find_by_email("customer#{i}@email.com")
  unless customer
    customer = User.create!(email: "customer#{i}@email.com", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: 'password2016', password_confirmation: 'password2016', role: 'customer')
  end

  agent = User.find_by_email("agent#{i}@email.com")
  unless agent
    agent = User.create!(email: "agent#{i}@email.com", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: 'password2016', password_confirmation: 'password2016', role: 'agent')
  end

  admin = User.find_by_email("admin#{i}@email.com")
  unless admin
    admin = User.create!(email: "admin#{i}@email.com", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: 'password2016', password_confirmation: 'password2016', role: 'admin')
  end
end

customers = User.customers
agents = User.agents
admins = User.admins
(1..40).each do |ctr|
  ticket = Ticket.new(
                          title: "Ticket No. #{ctr}",
                          description: Faker::Lorem.paragraph(2, false, 4),
                          status: :open,
                          priority: Ticket::PRIORITIES.sample,
                          reporter: customers.sample,
                          assignee: nil,
                          assignor: nil
                        )
  ticket.save!
end
(41..100).each do |ctr|
  ticket = Ticket.new(
                          title: "Ticket No. #{ctr}",
                          description: Faker::Lorem.paragraph(2, false, 4),
                          status: [:resolved, :working, :rejected, :closed].sample,
                          priority: Ticket::PRIORITIES.sample,
                          reporter: customers.sample,
                          assignee: agents.sample,
                          assignor: admins.sample
                        )
  ticket.save!
end
