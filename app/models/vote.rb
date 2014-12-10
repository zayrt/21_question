class Vote
	include Mongoid::Document

  field :answer_id,       type: Integer
  field :user_id,         type: Integer
  field :created_at,      type: DateTime
  field :updated_at,      type: DateTime
  field :answer_id,       type: String

    
  belongs_to :answer
  belongs_to :user
end
