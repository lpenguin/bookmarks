require 'rubygems'
require 'data_mapper' # requires all the gems listed above

#DataMapper.setup(:default, 'postgres://lpenguin:gfhjkm@localhost/main')
#DataMapper.setup(:default, 'sqlite:project.db')
require './models'

def show(node, level = 1)
    node.attachments.each do |attachment|
        print ' ' * (level)
        puts attachment.name
        show(attachment, level + 1)
    end
end

root = Folder.first()
puts root.name
show(root)