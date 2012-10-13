require 'sinatra'
require 'dropbox_sdk'
require_relative 'config'

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/open' do
end

get '/save' do
end

