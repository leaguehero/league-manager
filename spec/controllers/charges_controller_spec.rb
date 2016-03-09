require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  describe "GET New" do
    it "gets the new view" do
      get "new"
      response.status.should be 200
    end

    # it "gets the correct index view template" do
    #   get "index"
    #   response.should render_template("users/index")
    # end
  end

end
