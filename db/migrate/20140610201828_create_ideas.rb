class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :description
      t.references :user, index: true

      t.timestamps
    end
  end
end
