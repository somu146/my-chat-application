class AddIsPrivateToGroup < ActiveRecord::Migration[6.0]
  def change
  	add_column :groups, :is_private, :boolean
  end
end
