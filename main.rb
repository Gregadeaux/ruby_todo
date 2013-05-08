require 'sinatra'
require 'slim'
require 'sequel'

DB = Sequel.postgres('d94qvgiuv0n8vi', :user=>'gnswyxprjitnfe', :password=>'7qinf5GbGQgAZq7DWFgN-ok-9h', :host=>'ec2-54-235-155-182.compute-1.amazonaws.com', :port=>5432, max_connections=>20)

get '/' do
  slim :index
end

post '/' do
  @task = params[:task]
  slim :task
end

get '/:task' do
  @task = params[:task]
  slim :task
end