# frozen_string_literal: true

class OmniauthCallbacksController < ApplicationController
  def twitter
    nickname = auth.extra['access_token'].params[:screen_name]
    twitter_account = Current.user.twitter_accounts.where(username: nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      username: nickname,
      image: 'https://pbs.twimg.com/profile_images/1533723754521628674/etF7ssKg_400x400.png',
      token: auth.credentials.token,
      secret: auth.credentials.secrets
    )

    redirect_to twitter_accounts_path, notice: 'Successfully coneccted your account'
  end

  def auth
    request.env['omniauth.auth']
  end
end
