#To create plan in the db

p1 = Stripe::Plan.retrieve("free")
Plan.create(:stripe_id => p1.id, :name => p1.name, :price => p1.amount, :interval => p1.interval)
