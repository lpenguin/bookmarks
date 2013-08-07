require 'sinatra'
require 'erb'

require './models'
require './folder_helper'
require './api'

class View
	def self.index()
		{ :root_folders => FolderHelper.get_root_folder.attachments }
	end

	def self.folder(id)
		folder = Folder.find id
		{ :root_folders => folder.attachments }
	end
end