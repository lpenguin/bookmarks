require './models'
require './folder_helper'

require 'dm-serializer'
require 'json'

class Api
	def add_todo(command)
		Todo.create(
			:name => command['text']
			)
	end

	def add_bookmark(command)
		Bookmark.create(
			:name => command['title'],
			:url => command['url'],
			:description => command['text']
			)

	end

	def add_note(command)
		puts command['text']
		Note.create(
			:name => command['name'],
			:body => command['text']
			)
	end

	def folders()
		JSON.pretty_generate folders_rec FolderHelper.get_root_folder
	end

	def folders_rec(folder)
		children = []
		folder.attachments.each do |att|
			if att['type'] == 'Folder'
				children.push folders_rec(att)
			end
		end
		res = {
			:name => folder['name'],
			:children => children
		}
		return res
	end

	def remove_folder(id)
		folder = Folder.find id
		folder.delete
	end

	def get_tag(name)
		tag = Tag.first :name => name
		if tag == nil
			tag = Tag.new :name => name
		end
		tag
	end

	def add(data)
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
