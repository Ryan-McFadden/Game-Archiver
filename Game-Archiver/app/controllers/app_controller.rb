class AppController < Sinatra::Base
    enable :sessions
  
    configure do
      set :session_secret, "secret"
      set :public_folder, 'public'
      set :views, 'app/views'
    end
  
    get '/' do
      erb :'/home'
    end
  
  end