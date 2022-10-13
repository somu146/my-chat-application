class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, inverse_of: :messages

  def as_json(options)
    super(options).merge(
      username: user.username, user_avatar_url: user.gravatar_url
    )
  end
end
