class GroupChannel < ApplicationCable::Channel
  def subscribed
    group = Group.find_by id: params[:group]
    stream_for group
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
