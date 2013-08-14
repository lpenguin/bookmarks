#require "./api.rb"
require './models'
require './folder_helper'
require './api'

puts Api.folder_content 54
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