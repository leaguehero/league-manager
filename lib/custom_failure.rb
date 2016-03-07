class CustomFailure < Devise::FailureApp
  def redirect_url
    if params['user']['pre_league_id']
      "/users/sign_up?pre_league_id=#{params['user']['pre_league_id']}"
    else
      super
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
