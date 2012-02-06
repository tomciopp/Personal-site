require 'rubygems'
require 'sinatra'
require 'pony'
require 'sinatra/content_for'

set :email_username, ENV['SENDGRID_USERNAME'] ||
set :email_password, ENV['SENDGRID_PASSWORD'] ||
set :email_address, 'thomas.cioppettini@gmail.com'
set :email_service, ENV['EMAIL_SERVICE'] || 'gmail.com'
set :email_domain, ENV['SENDGRID_DOMAIN'] || 'localhost.localdomain'

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
        :address              => 'smtp.' + settings.email_service, 
        :port                 => '587', 
        :enable_starttls_auto => true, 
        :user_name            => settings.email_username, 
        :password             => settings.email_password, 
        :authentication       => :plain, 
        :domain               => settings.email_domain
      })
    redirect '/success'
end

get '/success' do
  @page_title = "Email sent" 
end

get '/class' do 
  @page_title = "Agile web development class"
  erb :class
end

get '/contact' do 
  erb :contact
end