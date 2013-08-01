require 'sinatra'
require "sinatra/jsonp"

use Rack::Logger
require 'erb'
require 'uri'

#require './enviroment.rb'
require './models'
require './views'
require './api'

api = Api.new
view = View.new

configure do
    set :bind => '188.40.18.175'
end

helpers do
  def logger
    request.logger
  end

  def get_favicon(url)
   myUri = URI.parse url
	return "http://#{myUri.host}/favicon.ico"
  end


end

post '/api/node/add/' do
	api.add params[:data]
  return 'ok'
end

get '/api/folders/get/' do
	return JSONP api.folders
end

get '/api/folder/remove/:id' do |id|
	api.remove_folder id
	redirect '/'
end

get '/' do
	erb :index , :locals => view.index
end
