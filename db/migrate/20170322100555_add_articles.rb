class AddArticles < ActiveRecord::Migration[5.0]
  def up
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :articles
  end
end
