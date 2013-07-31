require 'sinatra'
require 'erb'

require './models'
require './folder_helper'

class View
	def index()
		{ :bookmarks => Bookmark.all, :notes => Note.all, :todos => Todo.all, :root_folders => FolderHelper.get_root_folder.attachments }
	end
end