class AddColumnSessionExpiresAtToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :session_expires_at, :timestamp
  end
end
