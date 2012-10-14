require 'sinatra'
require 'dropbox_sdk'
require_relative 'config'
require_relative 'models'

enable :sessions
$db_client = nil

get '/' do
  begin
    redirect '/login' if !session['dropbox']

    session['dropbox'].get_access_token
  rescue DropboxError
    redirect '/login'
  end
  
  $db_client ||= DropboxClient.new(session['dropbox'], ACCESS_TYPE)
  uid = $db_client.account_info['uid']
  @user = User.first(dropbox_id: uid)
  @new_user = false

  @projects = {}
  if !@user
    @user = User.create(
      dropbox_id: uid, 
      access_token: session['dropbox'].access_token)
    $db_client.put_file("#{ROOT}/Project1/index.html", 'Hello World', true)
    @new_user = true
  end

  @projects = $db_client.metadata("#{ROOT}", 25000, true, nil, nil, false).fetch("contents")

  @js = ['lib/jquery', 'lib/underscore', 'lib/backbone', 'lib/ace/ace', 'dbide', 'models/file', 'views/files_view', 'views/file_view', 'views/main_view' ]
  erb :index
end

get '/login' do
  redirect '/' if session['dropbox'] and session['dropbox'].authorized?

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
    $db_client.file_create_folder("#{ROOT}/#{name}")
    return true
  rescue DropboxError
    return false
  end
end

get '/open' do
  return if !$db_client

  path = params[:path]
  if params[:is_dir]
    return $db_client.metadata("#{ROOT}/#{path}", 25000, true, nil, nil, false).fetch("contents")
  else
    return $db_client.get_file_and_metadata("#{ROOT}/#{path}")
  end
end

post '/save' do
  return if !$db_client

  path = params[:path]
  file = params[:content]
  $db_client.put_file('#{ROOT}/#{path}', file, true)
end
