class VotesController < ApplicationController
	def create
		a = Answer.find(params[:answer_id])
		vote = Vote.new
		vote.answer_id = params[:answer_id]
		vote.user_id = current_user.id
		vote.save
		redirect_to page_vote_path, notice: "You have voted"
	end
end