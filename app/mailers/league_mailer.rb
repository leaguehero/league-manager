class LeagueMailer < ApplicationMailer
  default from: 'getleaguehero@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to LeagueHero!')
  end

  def three_days_left(user)
    @user = user
    mail(to: @user.email, subject: '3 Days left of your LeagueHero Trial')
  end

  def one_day_left(user)
    @user = user
    mail(to: @user.email, subject: '1 Day Left of your League trial')
  end

  def trial_last_day(user)
    @user = user
    mail(to: @user.email, subject: 'Last day to keep your league! ')
  end

  def deleting_league_notice
    @user = user
    mail(to: @user.email, subject: 'NOTICE: League will be deleted today')
  end

end
