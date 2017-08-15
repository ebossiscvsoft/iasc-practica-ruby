require 'bundler/setup'

require 'active_support/all'
require 'sinatra'
require 'sinatra/base'

post '/io_bound' do
  {status: :ok}.to_json
end

post '/cpu_bound' do
  {status: :ok}.to_json
end

run Sinatra::Application
