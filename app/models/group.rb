class Group < ApplicationRecord
	has_many :messages, dependent: :destroy, inverse_of: :group
end
