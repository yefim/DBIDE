require 'sinatra'
require 'dropbox_sdk'
require_relative 'config'
require_relative 'models'

enable :sessions
$db_client = nil

get '/' do
  redirect 'login' if !session['dropbox']

  session['dropbox'].get_access_token
  $db_client = DropboxClient.new(session['dropbox'], ACCESS_TYPE) if !$db_client
  uid = $db_client.account_info['uid']
  @user = User.first(dropbox_id: uid)
  @new_user = false

  if !@user
    @user = User.create(
      dropbox_id: uid, 
      access_token: session['dropbox'].access_token)
    $db_client.put_file('/Public/DBIDE/Project1/index.html', 'Hello World')
    @new_user = true
  end

  @js = ['lib/jquery', 'lib/underscore', 'lib/backbone', 'lib/ace/ace', 'dbide', 'models/file', 'views/main_view']
  erb :index
end

get '/login' do
  db_session = DropboxSession.new(APP_KEY, APP_SECRET)
  session['dropbox'] = db_session
  db_session.get_request_token
  @authorize_url = db_session.get_authorize_url(SITE_URL)

  erb :login
end

post '/new' do
  return if !$db_client

  begin
    name = params[:name] || "Unnamed Project"
    db_client.file_create_folder('/Public/DBIDE/#{name}')
    return true
  rescue DropboxError
    return false
  end
end

post '/open' do
  return if !$db_client

  path = params[:path]
  content_type :json
  return db_client.get_file_and_metadata('/Public/DBIDE/#{path}').to_json
end

post '/save' do
end

