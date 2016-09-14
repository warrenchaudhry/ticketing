# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
customer = User.find_by_email('customer1@email.com')
unless customer
  customer = User.create!(email: 'customer1@email.com', first_name: 'First', last_name: 'Customer', password: 'password2016', role: 'customer')
end

agent = User.find_by_email('agent1@email.com')
unless agent
  agent = User.create!(email: 'agent1@email.com', first_name: 'First', last_name: 'Agent', password: 'password2016', role: 'agent')
end

admin = User.find_by_email('admin1@email.com')
unless admin
  admin = User.create!(email: 'admin1@email.com', first_name: 'First', last_name: 'Admin', password: 'password2016', role: 'admin')
end

customers = User.customers
agents = User.agents
admins = User.admins
(1..100).each do |ctr|
  ticket = Ticket.new(
                          title: "Ticket No. #{ctr}",
                          description: Faker::Lorem.paragraph(2, false, 4),
                          status: Ticket::STATUSES.sample,
                          priority: Ticket::PRIORITIES.sample,
                          reporter: customers.sample,
                          assignee: agents.sample,
                          assignor: admins.sample
                        )
  ticket.save!
end
