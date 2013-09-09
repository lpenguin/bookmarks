# encoding: utf-8

require './models'
require 'json'


class FirefoxImport


	def initialize()
		@folder_tag = 'text/x-moz-place-container'
		@bookmark_tag = 'text/x-moz-place'
		@root_folder_name = 'Unsorted Bookmarks'
		@trace_level = 0
	end	
	
	def trace(message)
		puts " "*@trace_level + message
	end

	def import_file(filename)
		str = open(filename, 'r', :encoding => 'utf-8').read
		jsonData = JSON.parse str.encode 'utf-8'
		self.import_json jsonData
	end

	def import_json(jsonData)
		# root_folder = self.find_folder_rec jsonData, @root_folder_name
		# self.trace("Found root folder: "+root_folder['title'])
		# self.import_folder root_folder
		# puts "root_folder: #{root_folder}"
	end

	def import_folder(folder_json)
		@trace_level = @trace_level + 1

		self.trace "importing folder #{folder_json['title']}" 

		folder = Folder.create(:name => folder_json['title'])

		attachments = []
		folder_json.children.each do |child|
			case child['type']
				when @bookmark_tag then folder.attachments << self.import_bookmark(child)
				when @folder_tag then folder.attachments <<  self.import_folder(child)
			end
		end
		@trace_level = @trace_level - 1
		return folder
	end

	def import_bookmark(bookmark_json)
		@trace_level = @trace_level + 1
		self.trace("importing bookmark "+bookmark_json['title'])
		bookmark = Bookmark.create (
			:name => bookmark_json['title'],
			:url => bookmark_json['uri']
		)
		@trace_level = @trace_level - 1
		return bookmark
	end

	def find_folder_rec(root, name)
		res = nil
		root['children'].each do |child|
			if child['type'] == @folder_tag 
				if child['title'] == name
					return child
				else
					res = self.find_folder_rec child, name
					if res != nil
						return res
					end
				end
			end
		end
		return res
	end
end