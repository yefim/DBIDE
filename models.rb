require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
# ENV val for heroku
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
# Serial - autoincrement unique key

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :access_token, String
  property :dropbox_id, String
  property :current_project, String #folder within DBIDE folder
  property :current_file, String #full file path
end

DataMapper.auto_migrate!
# ! means it can overwrite shit
# ? is existential operator - (a.nil?) is like (a == nil)