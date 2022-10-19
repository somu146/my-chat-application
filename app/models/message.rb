class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group, inverse_of: :messages, optional: true
  belongs_to :conversation, inverse_of: :messages, optional: true

  def as_json(options)
    super(options).merge(
      username: user.username, user_avatar_url: user.gravatar_url
    )
  end

  def opposed_user
    self.user == recipient ? sender : recipient
  end
end
