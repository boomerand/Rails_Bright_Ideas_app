class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :num_likes
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
