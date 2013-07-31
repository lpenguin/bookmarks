class CreateModels < ActiveRecord::Migration
  def self.up
  	#CREATE TABLE "nodes" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  	# "name" VARCHAR(255), "created_at" TIMESTAMP, "type" VARCHAR NOT NULL,
  	# "url" VARCHAR(255), "description" VARCHAR(255), "body" TEXT, "until" TIMESTAMP, "done" BOOLEAN, "root" BOOLEAN);
    create_table :nodes do |t|
		t.string :name
		t.string :type
		t.timestamp :created_at
		t.text :url
		t.text :description
		t.text :body
		t.timestamp :until
		t.boolean :done
		t.boolean :root
    end

    create_table :node_attachmentss do |t|
    	t.integer :node_id
    	t.integer :attached_id
    end
  end

  def self.down
    drop_table :nodes
    drop_table :node_attachmentss
  end
end
