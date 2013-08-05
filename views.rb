require 'sinatra'
require 'erb'

require './models'
require './folder_helper'
require './api'

class View
	def self.index()
		{ node_data: Api.nodes }
	end
end