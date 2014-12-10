class Answer
	include Mongoid::Document
	
	field :created_at,      type: DateTime
  field :updated_at,      type: DateTime
  field :answer,					type: String
  field :question_id, 		type: Integer

  belongs_to :question
  has_many :votes, dependent: :destroy
  validates :answer, presence: true, length: { minimum: 3 }
end
