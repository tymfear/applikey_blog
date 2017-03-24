class AddComments < ActiveRecord::Migration[5.0]
  def up
    create_table :comments do |t|
      t.text :body, null: false
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.belongs_to :article, index: true, null: false, foreign_key: true
      t.belongs_to :comment, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
