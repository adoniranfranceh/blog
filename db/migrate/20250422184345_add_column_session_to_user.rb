class AddColumnSessionToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :session, :uuid
  end
end
