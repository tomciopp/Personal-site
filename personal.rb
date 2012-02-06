require 'rubygems'
require 'sinatra'
require 'pony'
require 'sinatra/content_for'

helpers Sinatra::ContentFor

get '/' do 
  @page_title = "Welcome to tomciopp.com"
  erb :index
end

post '/contact' do 
  name = params[:name]
  sender_email = params[:email]
  message = params[:message]
    Pony.mail(
      :from => "#{name} <#{sender_email}>",
      :to => 'thomas.cioppettini@gmail.com',
      :subject =>"#{name} has contacted you",
      :body => "#{message}",
      :port => '587',
      :via => :smtp,
      :via_options => { 
        :address              => 'smtp.sendgrid.net', 
        :port                 => '587',  
        :user_name            => ENV['SENDGRID_USERNAME'], 
        :password             => ENV['SENDGRID_PASSWORD'], 
        :domain               => 'heroku.com',
        :authentication       => :plain, 
        :enable_starttls_auto => true
      })
    redirect '/success'
end

get '/success' do
  @page_title = "Email sent"
  erb :success 
end

get '/class' do 
  @page_title = "Agile web development class"
  erb :class
end

get '/contact' do 
  erb :contact
end