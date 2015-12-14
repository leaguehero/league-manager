#To create plan in the db

p1 = Stripe::Plan.retrieve("free")
Plan.create(:stripe_id => p1.id, :name => p1.name, :price => p1.amount, :interval => p1.interval)


#Test CreditCards
In test mode, you can use the card number 4242424242424242 with any CVC and a valid expiration date. Read more in our testing documentation.
