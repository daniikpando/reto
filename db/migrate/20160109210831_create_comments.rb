class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_user
      t.references :user, index: true, foreign_key: true
      t.integer :like_comment
      t.integer :dislike

      t.timestamps null: false
    end
  end
end
