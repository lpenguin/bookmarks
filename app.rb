require 'sinatra'
require "sinatra/jsonp"

use Rack::Logger
require 'erb'
require 'uri'

#require './enviroment.rb'
require './models'
require './views'
require './api'

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
  puts params[:data]
	Api.add params[:data]
  return 'ok'
end

get '/api/folders/get/' do
	return Api.folders
end

get '/api/folder/remove/:id' do |id|
	Api.remove_folder id
	redirect '/'
end

get '/api/folder/content/:id' do |id|
  Api.folder_content id
end

get '/' do
	erb :index , :locals => View.index
end

get '/folder/:id' do |id|
  erb :index, :locals => View.folder(id)
end

