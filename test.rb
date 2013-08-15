# encoding: utf-8

#require "./api.rb"
require './models'
require './folder_helper'
require './api'
require './firefox-bookmarks'

file = "test/bookmarks-2013-08-14.json"
importer = FirefoxImport.new
importer.import_file file
# require 'active_record'
# res =  Api.folder_content 165
# bookmark = Bookmark.find 164
# puts bookmark['name']
# puts bookmark.as_json.to_json
# # puts res.encode("UTF-8")
# puts res.encoding.name
# puts ActiveRecord::Base.connection.client_encoding() 
#Node.all.each do |n|
#	puts "#{n.name} #{n.type}"
#	if n.type == 'Bookmark'
#		puts n.url
#	end
#end

#puts FolderHelper.get_root_folder.to_json 

# puts "root #{root}"
# root.attachments.each do |a|
# 	puts "#{a.name}"
# end