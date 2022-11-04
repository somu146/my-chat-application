class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group, inverse_of: :messages, optional: true
  belongs_to :conversation, inverse_of: :messages, optional: true
  before_create :confirm_participant


  def as_json(options)
    super(options).merge(
      username: user.username, user_avatar_url: user.gravatar_url
    )
  end

  def opposed_user
    self.user == recipient ? sender : recipient
  end

  private
    def confirm_participant
      if group.is_private?
        is_participant = Participant.where(user_id: user.id, group_id: group.id).first
        throw :abort unless is_participant
      end
    end
end
