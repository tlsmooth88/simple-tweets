class SimpletweetsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @simpletweet = current_user.simpletweets.build(simpletweet_params)
    if @simpletweet.save
      flash[:success] = "Simple Tweet created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @simpletweet = current_user.simpletweets.find_by(id: params[:id])
    return redirect_to root_url if @simpletweet.nil?
    @simpletweet.destroy
    flash[:success] = "Simple tweet deleted!"
    redirect_to request.referrer || root_url
  end
  
  private
  def simpletweet_params
    params.require(:simpletweet).permit(:content)
  end
end
