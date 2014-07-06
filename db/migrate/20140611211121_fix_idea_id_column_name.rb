class FixIdeaIdColumnName < ActiveRecord::Migration
  def change
  	rename_column :likes, :post_id, :idea_id
  end
end
