require 'rubygems' 
require 'active_record' 

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3', 
  :database => 'database')

class A < ActiveRecord::Base
	has_many :links
	has_many :attachments, :through => :links, :source => 'attached'
end

class Link < ActiveRecord::Base
#  belongs_to :a
#  belongs_to :a
  belongs_to :a
  belongs_to :attached, :class_name => 'A'
end

class B < A
end

a = A.new
a.prop1 = "123"
a.save

b = B.new
b.prop1 = "1234"
b.prop2 = "234"
b.save

c = B.new(
	:prop1 => "111",
	:prop2 => "222"
)
c.save

b.attachments << c
a.attachments << b

puts "print A"
A.all.each do |a|
	puts "#{a.type}: #{a.prop1}"
end

puts "print B"
B.all.each do |b|
	puts "#{b.type}: #{b.prop1}, #{b.prop2}"
end

puts "print a.attachments"
a.attachments.each do |att|
	puts "#{att.type}: #{att.prop1}, #{att.prop2}"
end
