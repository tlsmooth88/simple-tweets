class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @simpletweet = current_user.simpletweets.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
