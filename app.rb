require 'sinatra'
require 'dropbox_sdk'
require_relative 'config'
require_relative 'models'

enable :sessions

get '/' do
  erb :index

  session['dropbox'].get_access_token
  client = DropboxClient.new(session['dropbox'], ACCESS_TYPE)
end

get '/login' do
  db_session = DropboxSession.new(APP_KEY, APP_SECRET)
  session['dropbox'] = db_session
  db_session.get_request_token
  @authorize_url = db_session.get_authorize_url('http://localhost:9393')

  erb :login
end

get '/open' do
end

get '/save' do
end

