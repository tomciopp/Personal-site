require 'rubygems'
require 'sinatra'


get '/' do 
  @page_title = "Welcome to tomciopp.com"
  erb :index
end

post '/' do 
  
end

get '/success' do
  @page_title = "Email sent" 
end

get '/presentation' do 
  @page_title = "Agile web development class"
end