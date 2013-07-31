require 'rubygems' 
require 'yaml'
require 'sinatra'
require 'sinatra/activerecord'

set :database, YAML::load(File.open('db/db.yml'))


class Node < ActiveRecord::Base
    has_many :links
    has_many :attachments, :through => :links, :source => 'attached'
end

class Link < ActiveRecord::Base
  belongs_to :node
  belongs_to :attached, :class_name => 'Node'
end

class Bookmark < Node
end

class Note < Node
end

class Todo < Node
end

class Folder < Node
end
