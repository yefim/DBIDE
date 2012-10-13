require 'sinatra'
require 'dropbox_sdk'
require_relative 'config'
require_relative 'models'

enable :sessions

get '/' do
  erb :index
end

get '/login' do
  session = DropboxSession.new(APP_KEY, APP_SECRET)
  session.get_request_token
  @authorize_url = session.get_authorize_url('http://localhost:9393')
  erb :login
end

get '/open' do
end

get '/save' do
end

