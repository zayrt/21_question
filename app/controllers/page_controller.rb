class PageController < ApplicationController
  def index
  end

  def test
  	if params[:token].nil?
  		@user = nil
  	else
  		@user = User.where(authentication_token: params[:token]).first
  		render json: @user
  	end
  end

  def vote

  	@question = Question.all
  	if user_signed_in?
  		raise current_user.inspect
  		@votes = Vote.where(user_id: current_user.id)
  	end
  end
end
