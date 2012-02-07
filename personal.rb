require 'rubygems'
require 'sinatra'
require 'pony'
require 'sinatra/content_for'
use Rack::Logger

helpers Sinatra::ContentFor
helpers do 
  def logger 
    request.logger
  end
end

get '/' do 
  @page_title = "Welcome to tomciopp.com"
  erb :index
end

post '/' do 
  configure_pony
  name = params[:name]
  sender_email = params[:email]
  message = params[:message]
  logger.error params.inspect
  begin
    Pony.mail(
      :from => "#{name}<#{sender_email}>",
      :to => 'thomas.cioppettini@gmail.com',
      :subject =>"#{name} has contacted you",
      :body => "#{message}",
    )
    redirect '/success'
  rescue
    @exception = $!
    erb :boom
  end
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

def configure_pony
  Pony.options = {
    :via => :smtp,
    :via_options => { 
      :address              => 'smtp.sendgrid.net', 
      :port                 => '587',  
      :user_name            => ENV['SENDGRID_USERNAME'], 
      :password             => ENV['SENDGRID_PASSWORD'], 
      :authentication       => :plain, 
      :enable_starttls_auto => true,
      :domain               => 'heroku.com'
    }    
  }
end