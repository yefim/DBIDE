require 'sinatra'
require 'dropbox_sdk'
require_relative 'config'
require_relative 'models'

enable :sessions

def open_file(path, db_client)
  db_client.get_file(path)
end

def open_folder(path, db_client)
  db_client.metadata(path, 25000, true, nil, nil, false).fetch("contents")
end

get '/' do
  begin
    redirect '/login' if !session['dropbox']

    session['dropbox'].get_access_token
  rescue DropboxError
    redirect '/login'
  end
  
  db_client ||= DropboxClient.new(session['dropbox'], ACCESS_TYPE)
  uid = db_client.account_info['uid']
  @user = User.first(dropbox_id: uid)
  @new_user = false

  @projects = {}
  if !@user
    @user = User.create(
      dropbox_id: uid, 
      access_token: session['dropbox'].access_token)
    db_client.put_file("#{ROOT}/Project1/index.html", 'Hello World', true)
    @new_user = true
  end

  @projects = open_folder(ROOT, db_client).map! {|x| x["path"] if x["is_dir"]}
  begin
    @current_file = {
      path: @user.current_file,
      content: open_file(@user.current_file, db_client)
    }
  rescue DropboxError
    @current_file = {}
  end

  if @user.editor === "default" or @user.editor === "normal"
    @editor = ""
  else
    @editor = @user.editor.downcase
  end

  @css = ['base', 'skeleton', 'layout', 'style', 'editor']
  @js = ['lib/jquery', 'lib/underscore', 'lib/backbone', 'lib/ace/ace', 'lib/ace/keybinding-vim', 'lib/ace/keybinding-emacs', 'dbide', 'templates/templates', 'models/file', 'views/edit_view', 'views/files_view', 'views/file_view', 'views/main_view' ]
  erb :index
end

get '/login' do
  redirect '/' if session['dropbox'] and session['dropbox'].authorized?

  db_session = DropboxSession.new(APP_KEY, APP_SECRET)
  session['dropbox'] = db_session
  db_session.get_request_token
  @authorize_url = db_session.get_authorize_url(SITE_URL)

  @css = ['base', 'skeleton', 'layout', 'style']
  erb :login
end

get '/logout' do
  begin
    redirect '/login' if !session['dropbox']

    session['dropbox'].get_access_token
  rescue DropboxError
    redirect '/login'
  end

  session.clear
  redirect '/'
end

post '/new' do
  begin
    name = params[:name] || "Unnamed Project"
    db_client ||= DropboxClient.new(session['dropbox'], ACCESS_TYPE)
    db_client.file_create_folder("#{ROOT}/#{name}")
    return true
  rescue DropboxError
    return false
  end
end

get '/open' do
  db_client ||= DropboxClient.new(session['dropbox'], ACCESS_TYPE)
  path = params[:path]
  file_or_folder = nil

  if params[:is_dir] != "false"
    # might have to use the map here? to extract, path and is_dir
    file_or_folder = open_folder(path, db_client)
  else
    file_or_folder = {
      path: path,
      content: open_file(path, db_client)
    }
  end
  content_type :json
  file_or_folder.to_json
end

post '/save' do
  db_client ||= DropboxClient.new(session['dropbox'], ACCESS_TYPE)
  params = JSON.parse request.body.read
  path = params["path"]
  file = params["content"] || ""
  db_client.put_file(path, file, true)

  # current file == last saved file
  uid = db_client.account_info['uid']
  @user = User.first(dropbox_id: uid)
  @user.update(current_file: path) # should also set last saves here

  content_type :json
  {path: path, content: file}.to_json
end

post '/mode' do
  db_client ||= DropboxClient.new(session['dropbox'], ACCESS_TYPE)
  mode = params["mode"]
  uid = db_client.account_info['uid']
  @user = User.first(dropbox_id: uid)
  @user.update(:editor => mode)
end
