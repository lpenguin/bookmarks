# encoding: utf-8
require './models'
require './folder_helper'

require 'dm-serializer'
require 'json'

class Api
	def self.add_todo(command)
		Todo.create(
			:name => command['text']
			)
	end

	def self.add_bookmark(command)
		Bookmark.create(
			:name => command['title'],
			:url => command['url'],
			:description => command['text']
			)

	end

	def self.add_note(command)
		puts command['text']
		Note.create(
			:name => command['name'],
			:body => command['text']
			)
	end

	def self.folders()
		JSON.pretty_generate node_rec FolderHelper.get_root_folder, only_folders: true
	end


	def self.nodes()
		self.node_rec_str FolderHelper.get_root_folder
	end

	def self.node_rec(node, only_folders=false)
		children = []
		node.attachments.each do |att|
			if (att['type'] == 'Folder' and only_folders) or not only_folders
				children.push node_rec(att, only_folders)
			end
		end
		res = {
			:name => node['name'],
			:children => children
		}
		return res		
	end

	def self.node_rec_str(node, only_folders=false)
		children = []
		node.attachments.each do |att|
			if (att['type'] == 'Folder' and only_folders) or not only_folders
				children.push node_rec_str(att, only_folders)
			end
		end
		name = node['name'].gsub("'", "\\'").gsub("\n", "\\n")
		children = children.join ', '
		res = "{ 'key': '#{name}', 'values': [#{children}] }"
		return res		
	end

	def self.remove_folder(id)
		folder = Folder.find id
		folder.delete
	end

	def self.get_tag(name) 
		tag = Tag.find_by :name => name
		if tag == nil
			tag = Tag.create :name => name
		else
			tag = tag.first
		end
		tag
	end

	def self.folder_content(id)
		folder = Folder.find id
		
		bookmarks = []
		notes = []
		todos = []

		folder.attachments.each do |attachment|
			case attachment['type']
			when 'Bookmark'
				bookmarks.push attachment
			when 'Note'
				notes.push attachment
			when 'Todo'
				todos.push attachment
			end
		end
		content = {
			:bookmarks => bookmarks,
			:notes => notes,
			:todos => todos
		}

		return content.to_json

	end

	def self.add(data)
		command = JSON.parse data
		t = command['type']
		puts "Type #{t}"
		case command['type']
		when 'todo'
			node = self.add_todo command
		when 'bookmark'
			node = self.add_bookmark command
		when 'note'
			node = self.add_note command
		end


		if command['tags'] != nil
			tags = command['tags']
			tags.each do |name|
				tag = self.get_tag name
				node.tags << tag
			end
		end

		if command['folders'] != nil
			command['folders'].each do |name|
				folder = FolderHelper.get_folder_by_path name
				folder.attachments << node
				folder.save				
			end
			
		end
		command['type']
	end
end

