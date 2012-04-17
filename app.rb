require "sinatra"
require "mogli"
require "sinatra/content_for"

set :raise_errors, false
set :show_exceptions, false

get "/channel" do
  script = "<script src=\"//connect.facebook.net/en_US/all.js\"></script>"
  erb script, :layout => false
end

get "/" do
  erb :index
end

get '/actionlinks' do
  bodystr = {"params" => CGI::parse(request.query_string)}.to_json
  Pony.mail({
    :to => 'sicross@gmail.com',
    :subject => 'action link click',
    :body => bodystr,
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  })
  {"params" => CGI::parse(request.query_string)}.to_json
end


get '/recipes/lasagne' do
  erb :lasagne
end

get '/recipes/thaigreencurry' do
  erb :thaigreencurry
end

get '/recipes/pizza' do
  erb :pizza
end

get '/ingredients/beef' do
  erb :beef
end

get '/ingredients/pasta' do
  erb :pasta
end

get '/occasions/birthday' do
  erb :birthday
end
