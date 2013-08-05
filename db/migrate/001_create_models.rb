class CreateModels < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
		t.string :name
		t.timestamp :created_at
    t.string :type
		t.text :url
		t.text :description
		t.text :body
		t.timestamp :until
		t.boolean :done
		t.boolean :root
    end

    create_table :links, :id => false do |t|
    	t.integer :node_id
    	t.integer :attached_id
    end
  end

  def self.down
    drop_table :nodes
    drop_table :links
  end
end
