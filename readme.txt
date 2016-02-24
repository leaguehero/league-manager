Ruby version is 2.2.2, to switch using rvm => $rvm ruby-2.2.2

##to start the app on port 3000 with background jobs
foreman start -p 3000
#starts rails with redis and Sidekiq
foreman start --procfile=Procfile.dev
open lvh.me:5000 in your browser
to view localhost when starting with foreman and testing subdomains, the url is 'lvh.me:5000'


#To create plan in the db

p1 = Stripe::Plan.retrieve("test_plan")
p1 = Stripe::Plan.retrieve("better_plan")
p1 = Stripe::Plan.retrieve("great_plan")
Plan.create(:stripe_id => p1.id, :name => p1.name, :price => p1.amount, :interval => p1.interval)

### Heroku
  To run heroku migrations: heroku run rake db:migrate
  To access heroku console: heroku run rails c
  To run web server: heroku ps:scale web=1
  To run worker server: heroku ps:scale worker=1
  View logs: heroku logs --tail

#Test CreditCards
In test mode, you can use the card number 4242424242424242 with any CVC and a valid expiration date. Read more in our testing documentation.

### To run ultrahook for stripe events
ultrahook stripe http://lvh.me:5000/stripe-event

### Apartment

#To create tenants using aparmtent gem
Apartment::Tenant.create("tenant_name")

#To switch into different Tenant databases
Apartment::Tenant.switch!('tenant_name')

#To remove a Tenant
Apartment::Tenant.drop('tenant_name')

#(DANGER)To remove ALL created Tenant
- tnts = League.pluck(:subdomain)
- tnts.each {|x| Apartment::Tenant.drop(x)}

### Sidekiq
to work with Sidekiq in console: require 'Sidekiq/api'
clear Retry jobs: Sidekiq::RetrySet.new.clear
#see stats from Sidekiq
stats = Sidekiq::Stats.new

# Add to migrations
rails g migration (ex:) addEmailToUsers email:string

### Stripe
Recurring payment plans are generated per league when they first sign up. The plan can be found using the league's name as the id. 
There is a 30 trial period attached to each league


###Created By
https://bitbucket.org/robschwartz/
https://bitbucket.org/aceeightofspades/


###Sources:
https://github.com/bernat/best_in_place
https://github.com/plataformatec/simple_form
https://github.com/flamontagne/rrschedule
