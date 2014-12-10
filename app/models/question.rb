class Question
	include Mongoid::Document

	field :created_at,      type: DateTime
  field :updated_at,      type: DateTime
  field :question,				type: String
  field :result_type,			type: String
  field :user_id,         type: Integer
	
  belongs_to :user
  validates :question, presence: true, length: { minimum: 3 }
  has_many :answers, dependent: :destroy


end
