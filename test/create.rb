require 'rubygems'
require 'data_mapper' # requires all the gems listed above

#DataMapper.setup(:default, 'postgres://lpenguin:gfhjkm@localhost/main')

require './models'

links = Node::Link.all()
links.destroy()

root = Folder.new(
    :name => 'root',
    :root => true
    )
    
todos = Folder.new(
    :name => 'Todos'
    )

bookmarks = Folder.new(
    :name => 'Bookmarks'
    )

root.attachments << todos
root.attachments << bookmarks

todo1 = Todo.new(
    :name => 'Clean kitchen'
    )

todo2 = Todo.new(
    :name => 'Buy bread',
    :done => true
    )
todos.attachments << todo1
todos.attachments << todo2

bookmark1 = Bookmark.new(
    :name => 'Yandex.ru',
    :url => 'Ya.ru'
    )
bookmarks.attachments << bookmark1

root.save()
