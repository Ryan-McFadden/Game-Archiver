class GamesController < AppController

    get '/games/new' do
        
        erb :'games/new'
    end

    post '/games' do
        user = Helpers.current_user(session)

        if params[:title].empty?

            redirect '/games/new'
        end

        @game = Game.create(title: params[:title], date: params[:date], description: params[:description], user_id: user.id)

        erb :'games/show'
    end

    get '/games/:id' do
        if !Helpers.is_logged_in?(session)
    
          redirect to '/home'
        end
    
        @game = Game.find(params[:id])
    
        erb :"games/show"
    end

    get '/games/:id/edit' do
        if !Helpers.is_logged_in?(session)
    
          redirect to '/home'
        end
    
        @game = Game.find(params[:id])
    
        if Helpers.current_user(session).id != @game.user_id
    
          redirect to '/show'
        end
    
        erb :"games/edit"
    end
    
    patch '/games/:id' do
    
        game = Game.find(params[:id])
    
        if params[:title].empty?
          redirect to "/games/#{params[:id]}/edit"
        end
    
        game.update(title: params[:title], date: params[:date], description: params[:description])
        game.save
    
        redirect to "/games/#{game.id}"
    end
    
    post '/games/:id/delete' do
        if !Helpers.is_logged_in?(session)
    
          redirect to '/home'
        end
    
        @game = Game.find(params[:id])
    
        if Helpers.current_user(session).id != @game.user_id
    
          redirect to '/show'
        end
    
        @game.delete
    
        redirect to '/show'
    end

end