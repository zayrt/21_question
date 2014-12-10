class QuestionsController < ApplicationController
	def get_full_error_msg obj
		if obj.errors.any?
  			full_msg = ""
  			if obj.errors.count == 1
  				full_msg += "1 error: " 
   			else
  				full_msg += obj.errors.count.to_s + " errors: "
	   		end
    		obj.errors.full_messages.each do |msg|
      			full_msg += msg + ". " 
    		end
    		return full_msg
    	end
	end

	def create
		question = Question.new question_params
		question.user_id = current_user.id
		if question.save
			params[:question].each do |key, value|
				save = false
				if key.to_s == "answer"
					answer = Answer.new answer_params
					answer.question_id = question.id
					save = true
				elsif key.to_s != "question" && key.to_s != "result_type" 
					answer = Answer.new({:answer => value})
					answer.question_id = question.id
					save = true
				end
				if save && !answer.save
					full_msg = get_full_error_msg answer
    				redirect_to root_path, alert: full_msg
    				return
   				end
   			end
   			redirect_to root_path, notice: "Your question has been added"
		else
			full_msg = get_full_error_msg question
			redirect_to root_path, alert: full_msg
		end
	end

	def destroy
		q = Question.find(params[:id])
		if q.destroy
			redirect_to root_path, notice: "Your question has been deleted"
		else
			redirect_to root_path, alert: "Delete question failed"
		end
	end

	def update
		@question = Question.find(params[:id])
		if @question.update(question_params)
			redirect_to root_path, notice: "Your question has been updated"
		else
			full_msg = get_full_error_msg @question 
			redirect_to root_path, alert: full_msg
		end
	end

	def edit
		@question = Question.find(params[:id])
	end

	def show
		@question = Question.find(params[:id])
		@reponses = Answer.where(question_id: params[:id])
	end

	private

	def question_params
		params.require(:question).permit(:question, :result_type)
	end

	def answer_params
		params.require(:question).permit(:answer)
	end
end
