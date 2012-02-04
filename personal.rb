require 'rubygems'
require 'sinatra'


get '/' do 
  @page_title = "Welcome to tomciopp.com"
  erb :index
end

post '/' do 
  name = params[:name]
  sender_email = params[:email]
  message = params[:message]
  require 'pony'
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
          :enable_starttls_auto => true, 
          :user_name            => ENV['SENDGRID_USERNAME'], 
          :password             => ENV['SENDGRID_PASSWORD'], 
          :authentication       => :plain, 
          :domain               => ENV['SENDGRID_DOMAIN']
        })
      redirect '/success'
end

get '/success' do
  @page_title = "Email sent" 
end

get '/presentation' do 
  @page_title = "Agile web development class"
end