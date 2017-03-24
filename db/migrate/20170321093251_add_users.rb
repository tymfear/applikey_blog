class AddUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string :username, unique: true
      t.string :email, unique: true
      t.string :password_digest
      t.text :avatar_data

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
