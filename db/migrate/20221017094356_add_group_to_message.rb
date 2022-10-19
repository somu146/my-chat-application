class AddGroupToMessage < ActiveRecord::Migration[6.0]
  def change
  	add_reference :messages, :group
  end
end
