class MakeUserReadyForInstaAuth < ActiveRecord::Migration[4.2]
  def change
    change_column_null :users, :email, true
    change_column_null :users, :encrypted_password, true

    add_column :users, :name, :string, null: true
  end
end
