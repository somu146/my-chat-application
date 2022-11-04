class Group < ApplicationRecord
	has_many :messages, dependent: :destroy, inverse_of: :group
	has_many :participants, dependent: :destroy
	has_many :users, through: :participants

	def create_participants(users)
		users.each do |user|
		  Participant.create(user_id: user.id, group_id: self.id )
		end
	end
end
