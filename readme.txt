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

### Demo customers
# log in to the heroku console by typing `heroku run rails c`
# Create User (remember the password you input into the user, if you forget it, you won't be able to recover)
(TIP: It's easiest to copy the line below and make your changes outside of the terminal, then input the command with all the correct data into the terminal)
- User.create(email: "email", password: "password", password_confirmation: "password", name: "name")
- After hitting enter, you will see the new User object, copy the new User's ID since you will need it when you create the league. If you loose the ID, you can find it by inputing `ap User.all` and it will most likely be the last User's ID that you want.
# Create League
(TIP: It's easiest to copy the line below and make your changes outside of the terminal, then input the command with all the correct data into the terminal)
- League.create(:name => "CUSTOM-LEAGUE-NAME", :url => "CUSTOM-LEAGUE-SUBDOMAIN.leaguehero.io",:max_teams => 10,:max_players_per_team => 10, :subdomain => "CUSTOM-LEAGUE-SUBDOMAIN",:admin_name => "LEAGUE ADMIN NAME",:admin_email => "LEAGUE ADMIN NAME",:user_id => DEMO USER ID)

### Testing
- To run tests run `rspec` in the terminal
- To see simplecov test coverage, open coverage/index.html in the browser

###Created By
https://bitbucket.org/robschwartz/
https://bitbucket.org/aceeightofspades/


###Sources:
https://github.com/bernat/best_in_place
https://github.com/plataformatec/simple_form
https://github.com/flamontagne/rrschedule
