require 'sinatra'
require 'slim'
require 'sequel'
require 'pg'

before do
  DB = Sequel.postgres('d94qvgiuv0n8vi', :user=>'gnswyxprjitnfe', :password=>'7qinf5GbGQgAZq7DWFgN-ok-9h', :host=>'ec2-54-235-155-182.compute-1.amazonaws.com', :port=>5432, :max_connections=>20)
  @items = DB[:items];
end

get '/' do
  @all = DB["Select * from items"]
  slim :index
end

post '/' do
  @task = params[:task]
  @items.insert(:name => @task)
  redirect to('/')
end

get '/:task' do
  @task = params[:task]
  slim :task
end