#To create plan in the db

p1 = Stripe::Plan.retrieve("test_plan")
p1 = Stripe::Plan.retrieve("better_plan")
p1 = Stripe::Plan.retrieve("great_plan")
Plan.create(:stripe_id => p1.id, :name => p1.name, :price => p1.amount, :interval => p1.interval)

#To run heroku migrations: heroku run rake db:migrate
#To access heroku console: heroku run rails c

#Test CreditCards
In test mode, you can use the card number 4242424242424242 with any CVC and a valid expiration date. Read more in our testing documentation.
