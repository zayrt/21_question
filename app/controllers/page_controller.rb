class PageController < ApplicationController
  def index
  end

  def vote
  	@question = Question.all
  	if user_signed_in?
  		@votes = Vote.where('user_id = ?', current_user.id)
  	end
  end
end
