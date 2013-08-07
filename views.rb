require 'sinatra'
require 'erb'

require './models'
require './folder_helper'
require './api'

class View
	def self.index()
		{ :root_folders => FolderHelper.get_root_folder.attachments }
	end
end