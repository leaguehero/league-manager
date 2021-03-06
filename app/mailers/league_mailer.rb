class LeagueMailer < ApplicationMailer
  default from: 'getleaguehero@gmail.com'

  def welcome_email(user, league)
    @user = user
    @league = league
    mail(to: @user.email, subject: 'Welcome to League Hero!', bcc: "getleaguehero@gmail.com")
  end

  def three_days_left(user, league)
    @league = League.find(league.id)
    @user = user
    mail(to: @user.email, subject: 'Only 3 Days left!')
  end

  def one_day_left(user, league)
    @user = user
    @league = League.find(league.id)

    mail(to: @user.email, subject: '1 Day Left of your League Hero trial!')
  end

  def trial_last_day(user,league)
    @user = user
    @league = League.find(league.id)
    mail(to: @user.email, subject: 'Last day to activate your League Hero league!')
  end

  def deleting_league_notice(user, league)
    @user = user
    @league = League.find(league.id)
    mail(to: @user.email, subject: 'NOTICE: Your League Hero league will be deleted today.')
  end

  def league_dues_email(player, price, league)
    @player = player
    @price = price
    @league = league
    mail(to: @player.email, subject: 'NOTICE: League dues for ' + @league.name + ' have been set')
  end

  def all_dues_paid(league)
    @league = league
    mail(to: @league.admin_email, cc: "getleaguehero@gmail.com", subject: 'NOTICE: All league dues for ' + @league.name + ' have been received!')
  end

end
