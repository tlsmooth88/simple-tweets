class StaticPagesController < ApplicationController
  def home
    @simpletweet = current_user.simpletweets.build if logged_in?
  end
end
