require 'sinatra'
require 'slim'
require 'sequel'
require 'pg'

before do
  DB = Sequel.postgres('d94qvgiuv0n8vi', :user=>'wkvjhxxbaxwcxt', :password=>'dWyrZHuBqfrMg9MlChtWIw_KZA', :host=>'ec2-54-235-155-182.compute-1.amazonaws.com', :port=>5432, :max_connections=>20)
  @items = DB[:items];
end

get '/' do
  @all = DB["Select * from items"]
  slim :index
end

post '/' do
  @task = params[:task]
  ps = @items.prepare(:insert, :insert_with_name, :name => :$n)
  ps.call(:n => @task)
  redirect to('/')
end

get '/:task' do
  @task = params[:task]
  slim :task
end

delete '/task/:id' do
  @items.where('id = ?', params[:id]).delete
  redirect to('/')
end

post '/task/:id' do
  @item = @items.where('id = ?', params[:id]).first
  slim :task
end

put '/task/:id' do
  @task = params[:task]
  old = @items.where('id = ?', params[:id]).first
  ps = @items.prepare(:update, :update_name, :name => :$new)
  ps.call(:n => ps[:name], :new_n = params[:task])
  redirect to('/')
end
  