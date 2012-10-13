require 'sinatra'
require 'dropbox_sdk'
require_relative 'config'
require_relative 'models'

enable :sessions

get '/' do
  redirect 'login' if !session['dropbox']

  session['dropbox'].get_access_token
  db_client = DropboxClient.new(session['dropbox'], ACCESS_TYPE)
  uid = db_client.account_info['uid']
  @user = User.first(dropbox_id: uid)

  if !@user
    @user = User.create(
      dropbox_id: uid, 
      access_token: session['dropbox'].access_token)
  end

  @js = ['/js/lib/jquery.js', '/js/lib/underscore.js', '/js/lib/backbone.js', '/js/lib/ace/ace.js']
  erb :index
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

