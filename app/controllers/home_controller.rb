# class HomeController < ApplicationController
#   def index
#     # on root directory, signout current_user since there is no sign in here.
#     # TODO: this needs to be fixed/ See if we use this
#     if current_user && (current_user.subdomain != request.subdomain)
#       sign_out current_user
#     end
#
#     render layout: "application"
#   end
# end
