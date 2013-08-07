class TagsAddNodeId < ActiveRecord::Migration
  def self.up
  	add_column :tags, :node_id, :integer
  end

  def self.down
    remove_colunm :tags, :node_id
  end

end