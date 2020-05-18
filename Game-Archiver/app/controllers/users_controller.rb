class UsersController < AppController

    get '/signup' do 

        erb :"users/signup"
    end

    post '/signup' do
        params.each do |label, input|
            if input.empty?

            redirect '/signup'
            end
        end

        if User.find_by(username: params[:username])
            user = User.find_by(username: params[:username])

            if user && user.authenticate(params[:password])
                session[:user_id] = user.id
          
                redirect '/show'
            else
                redirect '/signup'
            end
        end

        user = User.create(username: params[:username], email: params[:email], password: params[:password])
        session[:user_id] = user.id
        
        redirect '/show'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
    
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
    
          redirect '/show'
        else
        
          redirect '/'
        end
    end

    get '/show' do
        if Helpers.is_logged_in?(session)
            id = session[:user_id]
            @user = Helpers.current_user(session)

            erb :'users/show'
        else
            redirect '/'
        end
    end 

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear

            redirect '/'
        end
    end

end