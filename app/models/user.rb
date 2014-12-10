class User
	include Mongoid::Document
	include Mongoid::Search

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  class << self
    def serialize_from_session(key, salt)
      record = to_adapter.get(key[0]["$oid"])
      record if record && record.authenticatable_salt == salt
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :email,              						type: String,  default: ""
  field :encrypted_password, 						type: String,  default: ""
  field :reset_password_token, 					type: String
  field :reset_password_sent_at, 				type: DateTime
  field :remember_created_at, 					type: DateTime
  field :sign_in_count, 								type: Integer, default: 0
  field :current_sign_in_at, 						type: DateTime
  field :last_sign_in_at, 							type: DateTime
  field :current_sign_in_ip, 						type: String
  field :last_sign_in_ip, 							type: String
  field :created_at, 										type: DateTime
  field :updated_at, 										type: DateTime

  has_many :questions, dependent: :destroy
  has_many :votes, dependent: :destroy
end
