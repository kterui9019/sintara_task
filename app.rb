# coding:utf-8

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'sinatra/activerecord'
require "sqlite3"

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class Task < ActiveRecord::Base
end

get '/' do
  @tasks = Task.all
  erb :index
end

get '/show/:id' do
  @task = Task.find(params['id'])
  erb :show
end

get '/new' do
  erb :new
end

get '/edit/:id' do
  @task = Task.find(params['id'])
  erb :edit
end

post '/show/:id' do
  @task = Task.find(params['id'])
  @task.title = params['title']
  @task.detail = params['detail']
  @task.save
  erb :show
end

post '/create' do
  task = Task.create(:title => params['title'], :detail => params['detail'])
  task.save
  redirect '/'
end

get '/destroy/:id' do
  Task.find(params['id']).destroy
  redirect '/'
end