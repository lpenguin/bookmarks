#require "./api.rb"
require './models'
require './folder_helper'

#Node.all.each do |n|
#	puts "#{n.name} #{n.type}"
#	if n.type == 'Bookmark'
#		puts n.url
#	end
#end

root_folders = FolderHelper.get_root_folder.attachments
root_folders.each do |r|
	puts r.name
end

# puts "root #{root}"
# root.attachments.each do |a|
# 	puts "#{a.name}"
# end