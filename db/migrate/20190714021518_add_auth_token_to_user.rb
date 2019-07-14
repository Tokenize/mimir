class AddAuthTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string, limit: 32
  end
end
